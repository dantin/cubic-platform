package com.github.dantin.cubic.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.cloud.security.oauth2.gateway.TokenRelayGatewayFilterFactory;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class GatewayApplication {

  private final TokenRelayGatewayFilterFactory filterFactory;

  public GatewayApplication(TokenRelayGatewayFilterFactory filterFactory) {
    this.filterFactory = filterFactory;
  }

  public static void main(String[] args) {
    SpringApplication.run(GatewayApplication.class, args);
  }

  @Bean
  public RouteLocator myRoutes(RouteLocatorBuilder builder) {
    return builder
        .routes()
        .route(
            "ultrasound-api",
            p ->
                p.path("/api/ultrasound")
                    .filters(f -> f.filters(filterFactory.apply()).removeRequestHeader("Cookie"))
                    .uri("http://ultrasound-api:9000"))
        .build();
  }
}
