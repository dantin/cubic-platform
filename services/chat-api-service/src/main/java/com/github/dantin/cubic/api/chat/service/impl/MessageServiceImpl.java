package com.github.dantin.cubic.api.chat.service.impl;

import com.github.dantin.cubic.api.chat.config.RabbitMQConfig;
import com.github.dantin.cubic.api.chat.service.MessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;

@Service
public class MessageServiceImpl implements MessageService {

  private static final Logger LOGGER = LoggerFactory.getLogger(MessageServiceImpl.class);

  private final RabbitTemplate rabbitTemplate;

  public MessageServiceImpl(RabbitTemplate rabbitTemplate) {
    this.rabbitTemplate = rabbitTemplate;
  }

  @Override
  public void broadcast(String message) {
    rabbitTemplate.convertAndSend(
        RabbitMQConfig.ULTRASOUND_TOPIC, TopicRoute.BROADCAST.getAlias(), message);
  }

  @Override
  public void updateStatus(String message) {
    rabbitTemplate.convertAndSend(
        RabbitMQConfig.ULTRASOUND_TOPIC, TopicRoute.USER_STATUS.getAlias(), message);
  }
}
