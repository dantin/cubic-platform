package com.github.dantin.cubic.api.chat.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.SimpMessageType;
import org.springframework.security.config.annotation.web.messaging.MessageSecurityMetadataSourceRegistry;
import org.springframework.security.config.annotation.web.socket.AbstractSecurityWebSocketMessageBrokerConfigurer;

@Configuration
public class WebSocketSecurityConfig extends AbstractSecurityWebSocketMessageBrokerConfigurer {

  @Override
  protected void configureInbound(MessageSecurityMetadataSourceRegistry messages) {
    messages
        .simpTypeMatchers(
            SimpMessageType.CONNECT,
            SimpMessageType.UNSUBSCRIBE,
            SimpMessageType.DISCONNECT,
            SimpMessageType.HEARTBEAT)
        .permitAll()
        .simpDestMatchers("/api/**", "/topic/**")
        .authenticated()
        .simpSubscribeDestMatchers("/topic/**")
        .authenticated()
        .anyMessage()
        .denyAll();
  }

  @Override
  protected boolean sameOriginDisabled() {
    return true;
  }
}
