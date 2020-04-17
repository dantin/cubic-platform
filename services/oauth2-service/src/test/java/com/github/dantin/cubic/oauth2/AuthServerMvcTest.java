package com.github.dantin.cubic.oauth2;

import static org.junit.Assert.assertNotNull;

import io.restassured.RestAssured;
import io.restassured.response.Response;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

// need oauth2-service to be running.
public class AuthServerMvcTest {

  private static final String CLIENT_ID = "ultrasound_service";
  private static final String CLIENT_SECRET = "password";

  private Response obtainAccessToken(String username, String password) {
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("grant_type", "password");
    params.add("username", username);
    params.add("password", password);

    return RestAssured.given()
        .auth()
        .preemptive()
        .basic(CLIENT_ID, CLIENT_SECRET)
        .and()
        .with()
        .params(params)
        .when()
        .post("http://localhost:8083/oauth/token");
  }

  // @Test
  public void retrieveToken_thenOk() {
    Response authResponse = obtainAccessToken("root", "password");
    String accessToken = authResponse.jsonPath().getString("access_token");

    assertNotNull(accessToken);
  }
}
