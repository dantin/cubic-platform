package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.protocol.ultrasound.LoginRequest;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/auth")
public class AuthController {

  private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);

  @Value("${keycloak.resource}")
  private String clientId;

  @Value("${keycloak.credentials.secret}")
  private String clientSecret;

  @Value("${keycloak.auth-server-url}")
  private String authServerUrl;

  @Value("${keycloak.realm}")
  private String realm;

  private final RestTemplate restTemplate;

  public AuthController(@Qualifier("outerRest") RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  @PostMapping("/login")
  public ResponseEntity<String> login(@RequestBody LoginRequest request) {
    LOGGER.info("user '{}' login", request.getUsername());
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("client_id", clientId);
    params.add("grant_type", "password");
    params.add("client_secret", clientSecret);
    params.add("scope", "password");
    params.add("username", request.getUsername());
    params.add("password", request.getPassword());

    HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<>(params, headers);
    String tokenUrl =
        String.format("%s/realms/%s/protocol/openid-connect/token", authServerUrl, realm);
    ResponseEntity<String> response =
        restTemplate.exchange(tokenUrl, HttpMethod.POST, body, String.class);
    if (!response.getStatusCode().is2xxSuccessful() || Objects.isNull(response.getBody())) {
      LOGGER.warn("oauth failed with status code {}", response.getStatusCode());
    }
    return response;
  }
}
