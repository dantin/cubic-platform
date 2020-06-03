package com.github.dantin.cubic.api.chat.config;

import com.github.dantin.cubic.api.chat.service.auth.JWSAuthenticationToken;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/** Websocket configuration. */
@Configuration
@EnableWebSocketMessageBroker
public class StompConfig implements WebSocketMessageBrokerConfigurer {

  private static final Logger LOGGER = LoggerFactory.getLogger(StompConfig.class);

  private final AuthenticationManager authenticationManager;

  public StompConfig(@Qualifier("websocket") AuthenticationManager authenticationManager) {
    this.authenticationManager = authenticationManager;
  }

  @Override
  public void configureMessageBroker(MessageBrokerRegistry registry) {
    // prefix for incoming messages in '@MessageMapping'.
    registry.setApplicationDestinationPrefixes("/api");
    // enable broker '@SendTo("/topic/name")'
    registry.enableSimpleBroker("/topic");
  }

  @Override
  public void registerStompEndpoints(StompEndpointRegistry registry) {
    // add websocket endpoint '/ws'.
    registry.addEndpoint("/ws").setAllowedOrigins("*").withSockJS();
  }

  @Override
  public void configureClientInboundChannel(ChannelRegistration registration) {
    registration.interceptors(
        new ChannelInterceptor() {
          @SuppressWarnings("NullableProblems")
          @Override
          public Message<?> preSend(Message<?> message, MessageChannel channel) {
            StompHeaderAccessor accessor =
                MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
            if (StompCommand.CONNECT.equals(accessor.getCommand())) {
              Optional.ofNullable(accessor.getNativeHeader(HttpHeaders.AUTHORIZATION))
                  .ifPresent(
                      ah -> {
                        String bearerToken = ah.get(0).replace("Bearer ", "");
                        LOGGER.info("Received bearer token '{}'", bearerToken);
                        JWSAuthenticationToken token =
                            (JWSAuthenticationToken)
                                authenticationManager.authenticate(
                                    new JWSAuthenticationToken(bearerToken));
                        accessor.setUser(token);
                      });
            }
            return message;
          }
        });
  }
}
