package com.github.dantin.cubic.api.chat.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.PatternTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/** Websocket configuration. */
@Configuration
@EnableWebSocketMessageBroker
@EnableConfigurationProperties(ChannelProperties.class)
public class WebsocketConfig implements WebSocketMessageBrokerConfigurer {

  private static final Logger LOGGER = LoggerFactory.getLogger(WebsocketConfig.class);

  private final ChannelProperties channelProperties;

  public WebsocketConfig(ChannelProperties channelProperties) {
    this.channelProperties = channelProperties;
  }

  @Override
  public void registerStompEndpoints(StompEndpointRegistry registry) {
    // add websocket endpoint '/ws'.
    registry.addEndpoint("/ws").withSockJS();
  }

  @Override
  public void configureMessageBroker(MessageBrokerRegistry registry) {
    registry.setApplicationDestinationPrefixes("/api");
    registry.enableSimpleBroker("/topic");
  }

  @Bean
  RedisMessageListenerContainer redisMessageListenerContainer(
      RedisConnectionFactory redisConnectionFactory,
      MessageListenerAdapter messageListenerAdapter) {
    RedisMessageListenerContainer redisMessageListenerContainer =
        new RedisMessageListenerContainer();
    redisMessageListenerContainer.setConnectionFactory(redisConnectionFactory);

    // subscribe broadcast channel.
    String broadcastChannel = channelProperties.getBroadcast();
    redisMessageListenerContainer.addMessageListener(
        messageListenerAdapter, new PatternTopic(broadcastChannel));
    LOGGER.info("subscribed to redis '{}' channel", broadcastChannel);

    // subscribe user status channel.
    String userStatusChannel = channelProperties.getUserStatus();
    redisMessageListenerContainer.addMessageListener(
        messageListenerAdapter, new PatternTopic(userStatusChannel));
    LOGGER.info("subscribed to redis '{}' channel", userStatusChannel);

    return redisMessageListenerContainer;
  }
}
