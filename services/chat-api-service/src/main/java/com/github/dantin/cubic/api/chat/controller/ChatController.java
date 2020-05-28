package com.github.dantin.cubic.api.chat.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.api.chat.config.CustomizedKeyProperties;
import com.github.dantin.cubic.api.chat.service.MessageService;
import com.github.dantin.cubic.protocol.chat.ChatMessage;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

/** MessageController provides message related API. */
@Controller
@EnableConfigurationProperties(CustomizedKeyProperties.class)
public class ChatController {

  private static final Logger LOGGER = LoggerFactory.getLogger(ChatController.class);

  private final CustomizedKeyProperties customizedKeyProperties;
  private final RedisTemplate<String, String> redisTemplate;
  private final MessageService messageService;
  private final ObjectMapper objectMapper;

  @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
  public ChatController(
      CustomizedKeyProperties customizedKeyProperties,
      RedisTemplate<String, String> redisTemplate,
      MessageService messageService,
      ObjectMapper objectMapper) {
    this.customizedKeyProperties = customizedKeyProperties;
    this.redisTemplate = redisTemplate;
    this.messageService = messageService;
    this.objectMapper = objectMapper;
  }

  @MessageMapping("/message.sendMessage")
  public void sendMessage(@Payload ChatMessage message) {
    try {
      String json = objectMapper.writeValueAsString(message);
      messageService.broadcast(json);
    } catch (JsonProcessingException e) {
      LOGGER.warn("fail to serialize message {}", message, e);
    }
  }

  @MessageMapping("/message.joinUser")
  public void join(@Payload ChatMessage message, SimpMessageHeaderAccessor headerAccessor) {
    // Add username in web socket session
    LOGGER.info("user {} is joining", message.getSender());
    try {
      Objects.requireNonNull(headerAccessor.getSessionAttributes())
          .put("username", message.getSender());
      String json = objectMapper.writeValueAsString(message);
      // add online user.
      redisTemplate.opsForSet().add(customizedKeyProperties.getOnlineUser(), message.getSender());
      messageService.updateStatus(json);
    } catch (JsonProcessingException e) {
      e.printStackTrace();
    } catch (NullPointerException e) {
      LOGGER.warn("invalid message header", e);
    }
  }
}
