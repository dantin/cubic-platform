package com.github.dantin.cubic.api.chat;

import static org.junit.Assert.assertNotNull;

import com.github.dantin.cubic.base.CollectionsHelper;
import com.github.dantin.cubic.protocol.chat.ChatMessage;
import com.github.dantin.cubic.protocol.chat.ChatMessage.MessageType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.messaging.converter.MappingJackson2MessageConverter;
import org.springframework.messaging.simp.stomp.StompFrameHandler;
import org.springframework.messaging.simp.stomp.StompHeaders;
import org.springframework.messaging.simp.stomp.StompSession;
import org.springframework.messaging.simp.stomp.StompSessionHandlerAdapter;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.socket.client.standard.StandardWebSocketClient;
import org.springframework.web.socket.messaging.WebSocketStompClient;
import org.springframework.web.socket.sockjs.client.SockJsClient;
import org.springframework.web.socket.sockjs.client.Transport;
import org.springframework.web.socket.sockjs.client.WebSocketTransport;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(
    value = {"eureka.client.enabled:false"},
    webEnvironment = WebEnvironment.RANDOM_PORT)
public class ChatApiApplicationIntegrationTest {

  private static final String SEND_STATUS_ENDPOINT = "/api/message.joinUser";
  private static final String SEND_MESSAGE_ENDPOINT = "/api/message.sendMessage";
  private static final String SUBSCRIBE_STATUS_ENDPOINT = "/topic/public";
  private static final String SUBSCRIBE_MESSAGE_ENDPOINT = "/topic/public";

  @LocalServerPort private int port;

  private String endpoint;
  private CompletableFuture<ChatMessage> completableFuture;

  @Before
  public void setUp() {
    this.completableFuture = new CompletableFuture<>();
    this.endpoint = "ws://localhost:" + port + "/chat/ws";
  }

  @Test
  public void testSendStatusEndpoint()
      throws InterruptedException, ExecutionException, TimeoutException {
    WebSocketStompClient stompClient =
        new WebSocketStompClient(new SockJsClient(createTransportClient()));
    stompClient.setMessageConverter(new MappingJackson2MessageConverter());

    StompSession stompSession =
        stompClient.connect(endpoint, new StompSessionHandlerAdapter() {}).get(1, TimeUnit.SECONDS);

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
}
