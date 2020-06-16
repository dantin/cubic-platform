package com.github.dantin.cubic.protocol.ultrasound;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;

public class CodecTest {

  @Test
  public void marshalLoginRequest_thenSuccess() {
    final String username = "username";
    final String password = "password";

    LoginRequest loginRequest =
        LoginRequest.builder().username(username).password(password).build();
    LoginRequest actual = Utility.marshal(loginRequest, LoginRequest.class);

    assertNotNull(actual);
    assertThat(actual.getUsername(), is(username));
    assertThat(actual.getPassword(), is(password));
  }

  @Test
  public void marshalToken_thenSuccess() {
    final String accessToken = "access_token";
    final String refreshToken = "refresh_token";

    Token token = Token.builder().accessToken(accessToken).refreshToken(refreshToken).build();
    Token actual = Utility.marshal(token, Token.class);

    assertNotNull(actual);
    assertThat(actual.getAccessToken(), is(accessToken));
    assertThat(actual.getRefreshToken(), is(refreshToken));
  }

  private static class Utility {
    private static final ObjectMapper MAPPER = new ObjectMapper();

    public static <T> T marshal(T obj, Class<T> clazz) {
      try {
        // serialize
        String json = MAPPER.writeValueAsString(obj);
        // deserialize
        return MAPPER.readValue(json, clazz);
      } catch (JsonProcessingException e) {
        assertNull("serialize/deserialize error", e);
        return null;
      }
    }
  }
}
