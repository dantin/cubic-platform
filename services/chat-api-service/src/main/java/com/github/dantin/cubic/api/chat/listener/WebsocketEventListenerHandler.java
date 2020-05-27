package com.github.dantin.cubic.api.chat.listener;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.api.chat.config.CustomizedKeyProperties;
import com.github.dantin.cubic.api.chat.config.RabbitMQConfig;
import com.github.dantin.cubic.api.chat.config.TopicRoute;
import com.github.dantin.cubic.protocol.chat.ChatMessage;
import com.github.dantin.cubic.protocol.chat.ChatMessage.MessageType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.event.EventListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

@Component
@EnableConfigurationProperties(CustomizedKeyProperties.class)
public class WebsocketEventListenerHandler {

  private static final Logger LOGGER = LoggerFactory.getLogger(WebsocketEventListenerHandler.class);

  private final CustomizedKeyProperties customizedKeyProperties;

  private final RedisTemplate<String, String> redisTemplate;

  private final RabbitTemplate rabbitTemplate;

  private final ObjectMapper objectMapper;

  @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
  public WebsocketEventListenerHandler(
      CustomizedKeyProperties customizedKeyProperties,
      RedisTemplate<String, String> redisTemplate,
      RabbitTemplate rabbitTemplate,
      ObjectMapper objectMapper) {
    this.customizedKeyProperties = customizedKeyProperties;
    this.redisTemplate = redisTemplate;
    this.rabbitTemplate = rabbitTemplate;
    this.objectMapper = objectMapper;
  }

  @EventListener
  public void connectedHandle(@SuppressWarnings("unused") SessionConnectedEvent event) {
    LOGGER.info("receive a new web socket connection");
  }

  @EventListener
  public void disconnectHandle(SessionDisconnectEvent event) {
    StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

    //noinspection ConstantConditions
    Object value = headerAccessor.getSessionAttributes().get("username");
    if (value != null) {
      String username = (String) value;
      LOGGER.info("user {} disconnected", username);

      ChatMessage message = new ChatMessage();
      message.setType(MessageType.LEAVE);
      message.setSender(username);

      try {
        redisTemplate.opsForSet().remove(customizedKeyProperties.getOnlineUser(), username);
        String json = objectMapper.writeValueAsString(message);
        rabbitTemplate.convertAndSend(
            RabbitMQConfig.ULTRASOUND_TOPIC, TopicRoute.USER_STATUS.getAlias(), json);
      } catch (JsonProcessingException e) {
        LOGGER.warn("fail to serialize message to json on user {} disconnecting", username, e);
      }
    }
  }
}
