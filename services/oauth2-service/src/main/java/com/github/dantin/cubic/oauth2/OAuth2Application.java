package com.github.dantin.cubic.oauth2;

import com.github.dantin.cubic.oauth2.config.KeycloakServerProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.liquibase.LiquibaseAutoConfiguration;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Bean;

@SpringBootApplication(exclude = LiquibaseAutoConfiguration.class)
public class OAuth2Application {
  private static final Logger LOGGER = LoggerFactory.getLogger(OAuth2Application.class);

  public static void main(String[] args) {
    SpringApplication.run(OAuth2Application.class, args);
  }

  @Bean
  ApplicationListener<ApplicationReadyEvent> onApplicationReadyEventListener(
      ServerProperties serverProperties, KeycloakServerProperties keycloakServerProperties) {
    return (evt) -> {
      Integer port = serverProperties.getPort();
      String keycloakContextPath = keycloakServerProperties.getContextPath();

      LOGGER.info(
          "Embedded Keycloak started: http://localhost:{}{} to use keycloak",
          port,
          keycloakContextPath);
    };
  }
}
