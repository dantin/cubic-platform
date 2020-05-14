package com.github.dantin.cubic.gateway;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertNull;

import io.restassured.RestAssured;
import io.restassured.response.Response;
import org.json.JSONException;
import org.json.JSONObject;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;

// need all services to be running.
// @Ignore
public class GatewayIntegrationTest {

  @BeforeClass
  public static void init() {
    RestAssured.baseURI = "http://localhost";
    RestAssured.port = 8080;
  }

  @Test
  public void doLogin_thenSuccess() {
    String accessToken = obtainAccessToken("room01", "password");
    assertThat(accessToken).isNotBlank();
  }

  @Test
  public void userRetrieveRoom_thenSuccess() {
    String accessToken = obtainAccessToken("room01", "password");

    String url = "/ultrasound/room";
    Response response =
        RestAssured.given()
            .header("Authorization", "Bearer " + accessToken)
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .get(url);

    assertThat(HttpStatus.OK.value()).isEqualTo(response.getStatusCode());
    assertThat(response.jsonPath().getMap("$.")).containsKeys("id", "room", "streams");
  }

  @Test
  public void userListRoom_thenFail() {
    String accessToken = obtainAccessToken("room01", "password");

    String url = "/ultrasound/room/list";
    RestAssured.given()
        .header("Authorization", "Bearer " + accessToken)
        .contentType(MediaType.APPLICATION_JSON_VALUE)
        .get(url)
        .then()
        .statusCode(HttpStatus.FORBIDDEN.value());
  }

  @Test
  public void adminListRoom_thenSuccess() {
    String accessToken = obtainAccessToken("admin", "password");

    // default list
    String url = "/ultrasound/room/list";
    Response response =
        RestAssured.given()
            .header("Authorization", "Bearer " + accessToken)
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .get(url);

    assertThat(HttpStatus.OK.value()).isEqualTo(response.getStatusCode());
    assertThat(response.jsonPath().getMap("$."))
        .containsKeys("pages", "page", "total", "size", "has_previous", "has_next", "routes");

    // list by page
    response =
        RestAssured.given()
            .header("Authorization", "Bearer " + accessToken)
            .queryParam("n", "1")
            .queryParam("s", "4")
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .get(url);

    assertThat(HttpStatus.OK.value()).isEqualTo(response.getStatusCode());
    assertThat(response.jsonPath().getMap("$."))
        .containsKeys("pages", "page", "total", "size", "has_previous", "has_next", "routes");
    assertThat(response.jsonPath().getString("size")).isEqualTo("4");
    assertThat(response.jsonPath().getString("page")).isEqualTo("1");
    assertThat(response.jsonPath().getString("pages")).isEqualTo("2");
    assertThat(response.jsonPath().getString("has_next")).isEqualTo("true");
    assertThat(response.jsonPath().getString("has_previous")).isEqualTo("false");

    response =
        RestAssured.given()
            .header("Authorization", "Bearer " + accessToken)
            .queryParam("n", "2")
            .queryParam("s", "4")
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .get(url);

    assertThat(HttpStatus.OK.value()).isEqualTo(response.getStatusCode());
    assertThat(response.jsonPath().getMap("$."))
        .containsKeys("pages", "page", "total", "size", "has_previous", "has_next", "routes");
    assertThat(response.jsonPath().getString("size")).isEqualTo("1");
    assertThat(response.jsonPath().getString("page")).isEqualTo("2");
    assertThat(response.jsonPath().getString("pages")).isEqualTo("2");
    assertThat(response.jsonPath().getString("has_next")).isEqualTo("false");
    assertThat(response.jsonPath().getString("has_previous")).isEqualTo("true");
  }

  private String obtainAccessToken(String username, String password) {
    JSONObject json = null;
    try {
      json = new JSONObject().put("username", username).put("password", password);
    } catch (JSONException e) {
      assertNull(e);
    }

    String url = "/ultrasound/auth/login";
    Response response =
        RestAssured.given()
            .contentType(MediaType.APPLICATION_JSON_VALUE)
            .body(json.toString())
            .post(url);
    return response.jsonPath().getString("access_token");
  }
}
