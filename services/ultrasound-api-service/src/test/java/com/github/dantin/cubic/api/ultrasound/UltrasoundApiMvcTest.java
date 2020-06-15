package com.github.dantin.cubic.api.ultrasound;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.Matchers.hasSize;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.github.dantin.cubic.api.ultrasound.service.RoomService;
import com.github.dantin.cubic.protocol.room.Device;
import com.github.dantin.cubic.protocol.room.Role;
import com.github.dantin.cubic.protocol.room.Route;
import com.github.dantin.cubic.protocol.room.RoutePage;
import com.github.dantin.cubic.protocol.room.Stream;
import com.github.dantin.cubic.protocol.ultrasound.Token;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import java.util.UUID;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
public class UltrasoundApiMvcTest {

  @Autowired private WebApplicationContext context;

  @Autowired private MockMvc mockMvc;

  @MockBean private RoomService roomServiceMock;

  @Value("${keycloak.realm}")
  private String realm;

  @Value("${keycloak.resource}")
  private String clientId;

  @Value("${keycloak.credentials.secret}")
  private String clientSecret;

  @Before
  public void init() {
    // .alwaysDo(print())
    mockMvc = MockMvcBuilders.webAppContextSetup(context).apply(springSecurity()).build();

    RestAssured.baseURI = "http://localhost";
    RestAssured.port = 9990;
  }

  @Test
  public void doLogin_thenSuccess() throws Exception {
    String username = "room01";
    Token token = login(username);
    logout(token);
  }

  @Test
  public void getRoom_thenSuccess() throws Exception {
    final String username = "room01";
    Token token = login(username);

    // mock data
    Route.Builder builder = Route.builder().id("1").name("route 1");
    builder.addStream(
        Stream.builder()
            .role(Role.ADMIN.getAlias())
            .type(Device.CAMERA.getAlias())
            .uri("srt::" + UUID.randomUUID().toString())
            .build());
    builder.addStream(
        Stream.builder()
            .role(Role.ADMIN.getAlias())
            .type(Device.DEVICE.getAlias())
            .uri("srt::" + UUID.randomUUID().toString())
            .build());
    builder.addStream(
        Stream.builder()
            .role(Role.USER.getAlias())
            .type(Device.CAMERA.getAlias())
            .uri("srt::" + UUID.randomUUID().toString())
            .build());
    builder.addStream(
        Stream.builder()
            .role(Role.USER.getAlias())
            .type(Device.DEVICE.getAlias())
            .uri("srt::" + UUID.randomUUID().toString())
            .build());

    Route orig = builder.build();
    Mockito.when(roomServiceMock.getRoom(username)).thenReturn(orig);

    mockMvc
        .perform(
            MockMvcRequestBuilders.request(HttpMethod.GET, "/room")
                .header(HttpHeaders.AUTHORIZATION, bearerHeader(token.getAccessToken()))
                .accept(MediaType.APPLICATION_JSON))
        .andExpect(status().isOk())
        .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
        .andExpect(jsonPath("code", is(0)))
        .andExpect(jsonPath("data.id", is(orig.getId())))
        .andExpect(jsonPath("data.room", is(orig.getName())))
        .andExpect(jsonPath("data.streams", hasSize(orig.getStreams().size() / 2)))
        .andExpect(jsonPath("data.streams[0].role", is(orig.getStreams().get(2).getRole())))
        .andExpect(jsonPath("data.streams[0].type", is(orig.getStreams().get(2).getType())))
        .andExpect(jsonPath("data.streams[0].uri", is(orig.getStreams().get(2).getUri())))
        .andExpect(jsonPath("data.streams[1].role", is(orig.getStreams().get(3).getRole())))
        .andExpect(jsonPath("data.streams[1].type", is(orig.getStreams().get(3).getType())))
        .andExpect(jsonPath("data.streams[1].uri", is(orig.getStreams().get(3).getUri())));

    logout(token);
  }

  @Test
  public void listRoomByPage_thenSuccess() throws Exception {
    String username = "admin";
    Token token = login(username);
    listRoomByPage(token.getAccessToken(), 1, 8, 10);
    listRoomByPage(token.getAccessToken(), 2, 4, 4);
    logout(token);
  }

  private void listRoomByPage(String accessToken, int page, int size, int pages) throws Exception {
    // mock data
    RoutePage.Builder builder = RoutePage.builder();
    builder.pages(pages).page(page).size(size);
    for (int i = 0; i < size; i++) {
      int id = page * size + i;
      Route.Builder route = Route.builder().id(String.valueOf(id)).name("route " + id);
      route.addStream(
          Stream.builder()
              .role(Role.ADMIN.getAlias())
              .type(Device.CAMERA.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.ADMIN.getAlias())
              .type(Device.DEVICE.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.USER.getAlias())
              .type(Device.CAMERA.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.USER.getAlias())
              .type(Device.DEVICE.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      builder.addRoute(route.build());
    }

    Mockito.when(roomServiceMock.listRoomByPage(page, size)).thenReturn(builder.build());

    LinkedMultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("n", String.valueOf(page));
    params.add("s", String.valueOf(size));
    mockMvc
        .perform(
            MockMvcRequestBuilders.request(HttpMethod.GET, "/room/list")
                .header(HttpHeaders.AUTHORIZATION, bearerHeader(accessToken))
                .accept(MediaType.APPLICATION_JSON)
                .params(params))
        .andExpect(status().isOk())
        .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
        .andExpect(jsonPath("code", is(0)))
        .andExpect(jsonPath("data.pages", is(pages)))
        .andExpect(jsonPath("data.page", is(page)))
        .andExpect(jsonPath("data.size", is(size)))
        .andExpect(jsonPath("data.routes[0].streams", hasSize(2)));
  }

  @Test
  public void getUserProfile_thenSuccess() throws Exception {
    String username = "room01";
    Token token = login(username);
    String accessToken = bearerHeader(token.getAccessToken());
    mockMvc
        .perform(
            MockMvcRequestBuilders.request(HttpMethod.GET, "/user/profile")
                .header(HttpHeaders.AUTHORIZATION, accessToken)
                .accept(MediaType.APPLICATION_JSON))
        .andExpect(status().isOk())
        .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
        .andExpect(jsonPath("code", is(0)))
        .andExpect(jsonPath("data.username", is(username)));

    logout(token);
  }

  private Token login(String username) {
    String url = String.format("/auth/realms/%s/protocol/openid-connect/token", realm);
    // obtain authentication url with custom code
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("client_id", clientId);
    params.add("client_secret", clientSecret);
    params.add("grant_type", "password");
    params.add("username", username);
    params.add("password", "password");

    Response response = RestAssured.given().formParams(params).post(url);

    String accessToken = response.jsonPath().getString("access_token");
    assertNotNull(accessToken);
    String refreshToken = response.jsonPath().getString("refresh_token");
    assertNotNull(refreshToken);

    return Token.builder().accessToken(accessToken).refreshToken(refreshToken).build();
  }

  private void logout(Token token) {
    String url = String.format("/auth/realms/%s/protocol/openid-connect/logout", realm);
    // obtain authentication url with custom code
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("client_id", clientId);
    params.add("client_secret", clientSecret);
    params.add("refresh_token", token.getRefreshToken());

    Response response =
        RestAssured.given()
            .header(HttpHeaders.AUTHORIZATION, bearerHeader(token.getAccessToken()))
            .formParams(params)
            .post(url);

    assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
  }

  private String bearerHeader(String accessToken) {
    return String.format("Bearer %s", accessToken);
  }
}
