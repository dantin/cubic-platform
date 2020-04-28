package com.github.dantin.cubic.oauth2;

import org.junit.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@SpringBootTest(
    classes = {OAuth2Application.class},
    webEnvironment = WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
public class OAuth2MvcTest {

  @Test
  public void shouldReturnAuthToken() throws Exception {}
}
