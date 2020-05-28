package com.github.dantin.cubic.api.chat.listener;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.api.chat.config.RabbitMQConfig;
import com.github.dantin.cubic.api.chat.service.ChatService;
import com.github.dantin.cubic.protocol.chat.ChatMessage;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class RabbitMQListenerHandler {

  private static final Logger LOGGER = LoggerFactory.getLogger(RabbitMQListenerHandler.class);

  private final ChatService chatService;

  private final ObjectMapper objectMapper;

  public RabbitMQListenerHandler(ChatService chatService, ObjectMapper objectMapper) {
    this.chatService = chatService;
    this.objectMapper = objectMapper;
  }

  @RabbitListener(queues = {RabbitMQConfig.USER_STATUS_QUEUE})
  public void onUserStatusMessage(String content) {
    ChatMessage payload = parse(content);
    if (Objects.isNull(payload)) {
      return;
    }

    LOGGER.info("user '{}' status changed", payload.getSender());
    chatService.alertUserStatus(payload);
  }

  @RabbitListener(queues = {RabbitMQConfig.BROADCAST_QUEUE})
  public void onBroadcastMessage(String content) {
    ChatMessage payload = parse(content);
    if (Objects.isNull(payload)) {
      return;
    }
    LOGGER.info("sending message to all users");
    chatService.sendMessage(payload);
  }

  private ChatMessage parse(String content) {
    if (Objects.isNull(content)) {
      return null;
    }
    ChatMessage payload = null;
    try {
      payload = objectMapper.readValue(content, ChatMessage.class);
    } catch (JsonProcessingException e) {
      LOGGER.warn("fail to deserialize from message '{}'", content, e);
    }
    return payload;
  }
}
