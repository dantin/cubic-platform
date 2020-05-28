package com.github.dantin.cubic.api.chat;

import static org.assertj.core.api.Assertions.assertThatCode;
import static org.mockito.ArgumentMatchers.eq;

import com.github.dantin.cubic.api.chat.config.RabbitMQConfig;
import com.github.dantin.cubic.api.chat.service.MessageService;
import com.github.dantin.cubic.api.chat.service.MessageService.TopicRoute;
import com.github.dantin.cubic.api.chat.service.impl.MessageServiceImpl;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import org.springframework.amqp.rabbit.core.RabbitTemplate;

public class ChatApiApplicationUnitTest {

  private MessageService messageService;
  private RabbitTemplate rabbitTemplateMock;

  @Before
  public void setUp() {
    this.rabbitTemplateMock = Mockito.mock(RabbitTemplate.class);
    this.messageService = new MessageServiceImpl(this.rabbitTemplateMock);
  }

  @Test
  public void testBroadcast() {
    assertThatCode(() -> this.messageService.broadcast("Test")).doesNotThrowAnyException();

    Mockito.verify(this.rabbitTemplateMock)
        .convertAndSend(
            eq(RabbitMQConfig.ULTRASOUND_TOPIC), eq(TopicRoute.BROADCAST.getAlias()), eq("Test"));
  }

  @Test
  public void testUpdateStatus() {
    assertThatCode(() -> this.messageService.updateStatus("Test")).doesNotThrowAnyException();

    Mockito.verify(this.rabbitTemplateMock)
        .convertAndSend(
            eq(RabbitMQConfig.ULTRASOUND_TOPIC), eq(TopicRoute.USER_STATUS.getAlias()), eq("Test"));
  }
}
