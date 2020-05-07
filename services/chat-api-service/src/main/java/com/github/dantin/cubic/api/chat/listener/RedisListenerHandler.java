package com.github.dantin.cubic.api.chat.listener;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.api.chat.config.ChannelProperties;
import com.github.dantin.cubic.api.chat.service.ChatService;
import com.github.dantin.cubic.protocol.chat.ChatMessage;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.stereotype.Component;

@Component
@EnableConfigurationProperties(ChannelProperties.class)
public class RedisListenerHandler extends MessageListenerAdapter {

  private static final Logger LOGGER = LoggerFactory.getLogger(RedisListenerHandler.class);

  private final ChannelProperties channelProperties;

  private final ChatService chatService;

  private final RedisTemplate<String, String> redisTemplate;

  private final ObjectMapper objectMapper;

  public RedisListenerHandler(
      ChannelProperties channelProperties,
      ChatService chatService,
      RedisTemplate<String, String> redisTemplate,
      ObjectMapper objectMapper) {
    this.channelProperties = channelProperties;
    this.chatService = chatService;
    this.redisTemplate = redisTemplate;
    this.objectMapper = objectMapper;
  }

  @Override
  public void onMessage(Message message, byte[] pattern) {
    byte[] body = message.getBody();
    byte[] channel = message.getChannel();

    String rawContent;
    String topic;
    try {
      rawContent = redisTemplate.getStringSerializer().deserialize(body);
      topic = redisTemplate.getStringSerializer().deserialize(channel);
      LOGGER.info("receive message from topic '{}', raw content '{}'", topic, rawContent);
    } catch (Exception e) {
      LOGGER.warn(e.getMessage(), e);
      return;
    }

    ChatMessage payload = null;
    if (!Objects.isNull(rawContent)) {
      try {
        payload = objectMapper.readValue(rawContent, ChatMessage.class);
      } catch (JsonProcessingException e) {
        LOGGER.warn("fail to deserialize from message '{}'", rawContent, e);
        return;
      }
    }

    if (!Objects.isNull(payload)) {
      if (channelProperties.getBroadcast().equals(topic)) {
        LOGGER.info("sending message to all users");
        chatService.sendMessage(payload);
      } else if (channelProperties.getUserStatus().equals(topic)) {
        chatService.alertUserStatus(payload);
      }
    }
  }
}
