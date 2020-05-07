package com.github.dantin.cubic.api.chat.service.impl;

import com.github.dantin.cubic.api.chat.service.ChatService;
import com.github.dantin.cubic.protocol.chat.ChatMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Service;

@Service
public class ChatServiceImpl implements ChatService {

  private static final Logger LOGGER = LoggerFactory.getLogger(ChatServiceImpl.class);
  private static final String PUBLIC_TOPIC = "/topic/public";

  private final SimpMessageSendingOperations simpMessageSendingOperations;

  public ChatServiceImpl(SimpMessageSendingOperations simpMessageSendingOperations) {
    this.simpMessageSendingOperations = simpMessageSendingOperations;
  }

  @Override
  public void alertUserStatus(ChatMessage message) {
    LOGGER.info("user status change {}", message);
    simpMessageSendingOperations.convertAndSend(PUBLIC_TOPIC, message);
  }

  @Override
  public void sendMessage(@Payload ChatMessage message) {
    LOGGER.info("send message {}", message);
    simpMessageSendingOperations.convertAndSend(PUBLIC_TOPIC, message);
  }
}
