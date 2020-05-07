package com.github.dantin.cubic.api.chat.service;

import com.github.dantin.cubic.protocol.chat.ChatMessage;
import org.springframework.messaging.handler.annotation.Payload;

public interface MessageService {

  void alertUserStatus(@Payload ChatMessage message);

  void sendMessage(@Payload ChatMessage message);
}
