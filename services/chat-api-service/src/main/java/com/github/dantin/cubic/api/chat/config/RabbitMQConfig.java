package com.github.dantin.cubic.api.chat.config;

import com.github.dantin.cubic.api.chat.service.MessageService.TopicRoute;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.Declarables;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {

  private static final boolean NON_DURABLE = false;

  public static final String ULTRASOUND_TOPIC = "ultrasound-topic";
  public static final String USER_STATUS_QUEUE = "fanout.user-status.queue";
  public static final String BROADCAST_QUEUE = "fanout.broadcast.queue";

  @Bean
  public Declarables topicBinding() {
    Queue userStatusQueue = new Queue(USER_STATUS_QUEUE, NON_DURABLE);
    Queue broadcastQueue = new Queue(BROADCAST_QUEUE, NON_DURABLE);

    TopicExchange topicExchange = new TopicExchange(ULTRASOUND_TOPIC);

    return new Declarables(
        userStatusQueue,
        broadcastQueue,
        topicExchange,
        BindingBuilder.bind(userStatusQueue)
            .to(topicExchange)
            .with(TopicRoute.USER_STATUS.getAlias()),
        BindingBuilder.bind(broadcastQueue)
            .to(topicExchange)
            .with(TopicRoute.BROADCAST.getAlias()));
  }
}
