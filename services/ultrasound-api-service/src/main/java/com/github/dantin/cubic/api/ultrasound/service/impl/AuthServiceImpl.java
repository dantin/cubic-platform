package com.github.dantin.cubic.api.ultrasound.service.impl;

import com.github.dantin.cubic.api.ultrasound.service.AuthService;
import com.github.dantin.cubic.base.exception.BusinessException;
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
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class AuthServiceImpl implements AuthService {

  private static final Logger LOGGER = LoggerFactory.getLogger(AuthServiceImpl.class);

  @Value("${keycloak.resource}")
  private String clientId;

  @Value("${keycloak.credentials.secret}")
  private String clientSecret;

  @Value("${keycloak.auth-server-url}")
  private String authServerUrl;

  @Value("${keycloak.realm}")
  private String realm;

  private final RestTemplate restTemplate;

  public AuthServiceImpl(@Qualifier("edgeClient") RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  @Override
  public String login(String username, String password) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("client_id", clientId);
    params.add("grant_type", "password");
    params.add("client_secret", clientSecret);
    params.add("username", username);
    params.add("password", password);

    HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<>(params, headers);
    String tokenUrl =
        String.format("%s/realms/%s/protocol/openid-connect/token", authServerUrl, realm);
    ResponseEntity<String> response =
        restTemplate.exchange(tokenUrl, HttpMethod.POST, body, String.class);
    if (!response.getStatusCode().is2xxSuccessful() || Objects.isNull(response.getBody())) {
      LOGGER.warn("oauth failed with status code {}", response.getStatusCode());
      throw new BusinessException("authentication failed");
    }
    return response.getBody();
  }

  @Override
  public String refreshToken(String refreshToken) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("client_id", clientId);
    params.add("grant_type", "refresh_token");
    params.add("client_secret", clientSecret);
    params.add("refresh_token", refreshToken);

    HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<>(params, headers);
    String tokenUrl =
        String.format("%s/realms/%s/protocol/openid-connect/token", authServerUrl, realm);
    ResponseEntity<String> response =
        restTemplate.exchange(tokenUrl, HttpMethod.POST, body, String.class);
    if (!response.getStatusCode().is2xxSuccessful() || Objects.isNull(response.getBody())) {
      LOGGER.warn("refresh token failed with status code {}", response.getStatusCode());
      throw new BusinessException("authentication failed");
    }
    return response.getBody();
  }

  @Override
  public void logout(String accessToken, String refreshToken) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    headers.setBearerAuth(accessToken);
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("client_id", clientId);
    params.add("client_secret", clientSecret);
    params.add("refresh_token", refreshToken);

    HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<>(params, headers);
    String tokenUrl =
        String.format("%s/realms/%s/protocol/openid-connect/logout", authServerUrl, realm);
    ResponseEntity<String> response =
        restTemplate.exchange(tokenUrl, HttpMethod.POST, body, String.class);
    if (!response.getStatusCode().is2xxSuccessful()) {
      LOGGER.warn("logout failed with status code {}", response.getStatusCode());
      throw new BusinessException("authentication failed");
    }
  }
}
