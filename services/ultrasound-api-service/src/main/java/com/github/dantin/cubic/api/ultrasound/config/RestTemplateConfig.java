package com.github.dantin.cubic.api.ultrasound.config;

import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RestTemplateConfig {

  @Bean(name = "clusterClient")
  @LoadBalanced
  public RestTemplate clusterClient() {
    return new RestTemplate();
  }

  @Bean(name = "edgeClient")
  public RestTemplate edgeClient() {
    return new RestTemplate();
  }
}
