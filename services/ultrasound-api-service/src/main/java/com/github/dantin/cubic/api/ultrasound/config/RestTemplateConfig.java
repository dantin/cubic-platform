package com.github.dantin.cubic.api.ultrasound.config;

import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RestTemplateConfig {

  @Bean(name = "cloudRest")
  @LoadBalanced
  public RestTemplate restTemplate() {
    return new RestTemplate();
  }

  @Bean(name = "outerRest")
  public RestTemplate restTemplate2() {
    return new RestTemplate();
  }
}
