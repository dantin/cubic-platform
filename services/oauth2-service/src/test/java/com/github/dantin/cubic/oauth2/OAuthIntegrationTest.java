package com.github.dantin.cubic.oauth2;

import static org.assertj.core.api.Assertions.assertThat;

import io.restassured.RestAssured;
import io.restassured.response.Response;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.http.HttpStatus;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

// need oauth2-service to be running.
@Ignore
public class OAuthIntegrationTest {

  @Test
  public void whenServiceStartsAndLoadsRealmConfiguration_thenOidcDiscoveryEndpointIsAvailable() {
    String oidcDiscoveryUrl =
        "http://localhost:8083/auth/realms/cubic/.well-known/openid-configuration";

    Response response = RestAssured.given().redirects().follow(false).get(oidcDiscoveryUrl);

    assertThat(HttpStatus.OK.value()).isEqualTo(response.getStatusCode());
    System.out.println(response.asString());
    assertThat(response.jsonPath().getMap("$."))
        .containsKeys("issuer", "authorization_endpoint", "token_endpoint", "userinfo_endpoint");
  }

  @Test
  public void givenAuthorizationCodeGrant_whenObtainAccessToken_thenSuccess() {
    String accessToken = obtainAccessToken();
    assertThat(accessToken).isNotBlank();
  }

  private String obtainAccessToken() {
    // curl -L -X POST 'http://localhost:8083/auth/realms/cubic/protocol/openid-connect/token' -H
    // 'Content-Type: application/x-www-form-urlencoded' --data-urlencode
    // 'client_id=ultrasound_api_client' --data-urlencode 'grant_type=password' --data-urlencode
    // 'client_secret=password' --data-urlencode 'scope=read' --data-urlencode
    // 'username=john@test.com' --data-urlencode 'password=123' | jq
    String tokenUrl = "http://localhost:8083/auth/realms/cubic/protocol/openid-connect/token";
    // obtain authentication url with custom code
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("client_id", "ultrasound_api_service");
    params.add("grant_type", "password");
    params.add("client_secret", "password");
    params.add("scope", "read");
    params.add("username", "room01");
    params.add("password", "password");

    Response response = RestAssured.given().formParams(params).post(tokenUrl);
    System.out.println(response.asString());
    return response.jsonPath().getString("access_token");
  }
}
