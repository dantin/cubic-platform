package com.github.dantin.cubic.gateway;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.base.CollectionsHelper;
import com.github.dantin.cubic.protocol.chat.ChatMessage;
import com.github.dantin.cubic.protocol.chat.ChatMessage.MessageType;
import com.github.dantin.cubic.protocol.ultrasound.Token;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import java.lang.reflect.Type;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import org.json.JSONException;
import org.json.JSONObject;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.messaging.converter.MappingJackson2MessageConverter;
import org.springframework.messaging.simp.stomp.StompFrameHandler;
import org.springframework.messaging.simp.stomp.StompHeaders;
import org.springframework.messaging.simp.stomp.StompSession;
import org.springframework.messaging.simp.stomp.StompSessionHandlerAdapter;
import org.springframework.web.socket.client.standard.StandardWebSocketClient;
import org.springframework.web.socket.messaging.WebSocketStompClient;
import org.springframework.web.socket.sockjs.client.SockJsClient;
import org.springframework.web.socket.sockjs.client.Transport;
import org.springframework.web.socket.sockjs.client.WebSocketTransport;

// need all services to be running.
public class GatewayIntegrationTest {

  private final ObjectMapper MAPPER = new ObjectMapper();
  private static final String SEND_STATUS_ENDPOINT = "/api/message.joinUser";
  private static final String SEND_MESSAGE_ENDPOINT = "/api/message.sendMessage";
  private static final String SUBSCRIBE_STATUS_ENDPOINT = "/topic/public";
  private static final String SUBSCRIBE_MESSAGE_ENDPOINT = "/topic/public";

  private String endpoint;
  private CompletableFuture<ChatMessage> completableFuture;

  @BeforeClass
  public static void init() {
    RestAssured.baseURI = "http://localhost";
    RestAssured.port = 8080;
  }

  @Before
  public void setUp() {
    this.completableFuture = new CompletableFuture<>();
    this.endpoint = "ws://localhost:8080/chat/ws";
  }

  @Test
  public void doLogin_thenSuccess() {
    Token token = login("room01", "password");
    assertNotNull(token);
    Token updatedToken = refreshToken(token);
    assertNotNull(updatedToken);
    assertNotEquals(token.getAccessToken(), updatedToken.getAccessToken());
    logout(updatedToken);
  }

  @Test
  public void reLogin_thenFail() {
    String username = "room01";
    String password = "password";
    Token token = login(username, password);
    assertNotNull(token);

    JSONObject json = null;
    try {
      json = new JSONObject().put("username", username).put("password", password);
    } catch (JSONException e) {
      assertNull(e);
    }

    String url = "/ultrasound/auth/login";
    Response response =
        RestAssured.given()
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .body(json.toString())
            .post(url);
    assertEquals(HttpStatus.BAD_REQUEST.value(), response.getStatusCode());

    logout(token);
  }

  @Test
  public void userRetrieveRoom_thenSuccess() {
    Token token = login("room01", "password");

    String url = "/ultrasound/room";
    Response response =
        RestAssured.given()
            .header("Authorization", bearerHeader(token.getAccessToken()))
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .get(url);

    assertThat(HttpStatus.OK.value()).isEqualTo(response.getStatusCode());
    assertThat(response.jsonPath().getMap("$.")).containsKeys("id", "room", "streams");
    logout(token);
  }

  @Test
  public void userListRoom_thenFail() {
    Token token = login("room01", "password");

    String url = "/ultrasound/room/list";
    RestAssured.given()
        .header(HttpHeaders.AUTHORIZATION, bearerHeader(token.getAccessToken()))
        .contentType(MediaType.APPLICATION_JSON_VALUE)
        .get(url)
        .then()
        .statusCode(HttpStatus.FORBIDDEN.value());
    logout(token);
  }

  @Test
  public void adminListRoom_thenSuccess() {
    Token token = login("admin", "password");

    // default list
    String url = "/ultrasound/room/list";
    Response response =
        RestAssured.given()
            .header(HttpHeaders.AUTHORIZATION, bearerHeader(token.getAccessToken()))
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .get(url);
    assertEquals(HttpStatus.OK.value(), response.getStatusCode());

    assertThat(response.jsonPath().getMap("$."))
        .containsKeys("pages", "page", "total", "size", "has_previous", "has_next", "routes");

    // list by page
    response =
        RestAssured.given()
            .header(HttpHeaders.AUTHORIZATION, bearerHeader(token.getAccessToken()))
            .queryParam("n", "1")
            .queryParam("s", "4")
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .get(url);
    assertEquals(HttpStatus.OK.value(), response.getStatusCode());

    assertThat(response.jsonPath().getMap("$."))
        .containsKeys("pages", "page", "total", "size", "has_previous", "has_next", "routes");
    assertThat(response.jsonPath().getString("size")).isEqualTo("4");
    assertThat(response.jsonPath().getString("page")).isEqualTo("1");
    assertThat(response.jsonPath().getString("pages")).isEqualTo("2");
    assertThat(response.jsonPath().getString("has_next")).isEqualTo("true");
    assertThat(response.jsonPath().getString("has_previous")).isEqualTo("false");

    response =
        RestAssured.given()
            .header(HttpHeaders.AUTHORIZATION, bearerHeader(token.getAccessToken()))
            .queryParam("n", "2")
            .queryParam("s", "4")
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .get(url);
    assertEquals(HttpStatus.OK.value(), response.getStatusCode());

    assertThat(response.jsonPath().getMap("$."))
        .containsKeys("pages", "page", "total", "size", "has_previous", "has_next", "routes");
    assertThat(response.jsonPath().getString("size")).isEqualTo("1");
    assertThat(response.jsonPath().getString("page")).isEqualTo("2");
    assertThat(response.jsonPath().getString("pages")).isEqualTo("2");
    assertThat(response.jsonPath().getString("has_next")).isEqualTo("false");
    assertThat(response.jsonPath().getString("has_previous")).isEqualTo("true");
    logout(token);
  }

  private Token login(String username, String password) {
    JSONObject json = null;
    try {
      json = new JSONObject().put("username", username).put("password", password);
    } catch (JSONException e) {
      assertNull(e);
    }

    String url = "/ultrasound/auth/login";
    Response response =
        RestAssured.given()
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .body(json.toString())
            .post(url);
    assertEquals(HttpStatus.OK.value(), response.getStatusCode());

    String accessToken = response.jsonPath().getString("access_token");
    assertThat(accessToken).isNotEmpty();
    String refreshToken = response.jsonPath().getString("refresh_token");
    assertThat(refreshToken).isNotEmpty();

    Token token = new Token();
    token.setAccessToken(accessToken);
    token.setRefreshToken(refreshToken);
    return token;
  }

  private Token refreshToken(Token token) {
    String url = "/ultrasound/auth/refresh";
    Response response =
        RestAssured.given()
            .header(HttpHeaders.AUTHORIZATION, bearerHeader(token.getAccessToken()))
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .body(asJsonString(token))
            .post(url);
    assertEquals(HttpStatus.OK.value(), response.getStatusCode());

    String accessToken = response.jsonPath().getString("access_token");
    assertThat(accessToken).isNotEmpty();
    String refreshToken = response.jsonPath().getString("refresh_token");
    assertThat(refreshToken).isNotEmpty();

    Token updatedToken = new Token();
    updatedToken.setAccessToken(accessToken);
    updatedToken.setRefreshToken(refreshToken);
    return updatedToken;
  }

  private void logout(Token token) {
    String url = "/ultrasound/auth/logout";
    Response response =
        RestAssured.given()
            .header(HttpHeaders.AUTHORIZATION, bearerHeader(token.getAccessToken()))
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .body(asJsonString(token))
            .post(url);
    assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
  }

  @Test
  public void sendStatusEndpoint_thenSuccess()
      throws InterruptedException, ExecutionException, TimeoutException {
    WebSocketStompClient stompClient =
        new WebSocketStompClient(new SockJsClient(createTransportClient()));
    stompClient.setMessageConverter(new MappingJackson2MessageConverter());

    StompSession stompSession =
        stompClient.connect(endpoint, new StompSessionHandlerAdapter() {}).get(3, TimeUnit.SECONDS);

    ChatMessage body = new ChatMessage();
    body.setType(MessageType.JOIN);
    body.setSender("test-user");
    body.setContent("{\"content\": \"json content\"}");

    stompSession.subscribe(SUBSCRIBE_STATUS_ENDPOINT, new ChatMessageStompFrameHandler());
    stompSession.send(SEND_STATUS_ENDPOINT, body);

    ChatMessage chatMessage = completableFuture.get(10, TimeUnit.SECONDS);
    assertNotNull(chatMessage);
  }

  private List<Transport> createTransportClient() {
    return CollectionsHelper.listOf(new WebSocketTransport(new StandardWebSocketClient()));
  }

  @SuppressWarnings("NullableProblems")
  private class ChatMessageStompFrameHandler implements StompFrameHandler {

    @Override
    public Type getPayloadType(StompHeaders headers) {
      return ChatMessage.class;
    }

    @Override
    public void handleFrame(StompHeaders headers, Object payload) {
      completableFuture.complete((ChatMessage) payload);
    }
  }

  private String bearerHeader(String accessToken) {
    return String.format("Bearer %s", accessToken);
  }

  private String asJsonString(final Object obj) {
    try {
      return MAPPER.writeValueAsString(obj);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }
}
