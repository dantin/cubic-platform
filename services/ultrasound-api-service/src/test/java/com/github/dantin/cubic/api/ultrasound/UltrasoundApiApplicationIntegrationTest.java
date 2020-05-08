package com.github.dantin.cubic.api.ultrasound;

import static org.junit.Assert.assertNotNull;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.tngtech.keycloakmock.api.KeycloakVerificationMock;
import com.tngtech.keycloakmock.api.TokenConfig;
import java.time.Instant;
import java.util.Objects;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
public class UltrasoundApiApplicationIntegrationTest {

  @Autowired private WebApplicationContext context;

  @Autowired private MockMvc mockMvc;

  @Value("${keycloak.resource}")
  private String clientId;

  @Value("${keycloak.credentials.secret}")
  private String clientSecret;

  private static KeycloakVerificationMock keycloakMock;

  @BeforeClass
  public static void prepare() {
    keycloakMock = new KeycloakVerificationMock(8083, "ultrasound");
    keycloakMock.start();
  }

  @AfterClass
  public static void tearDown() {
    if (!Objects.isNull(keycloakMock)) {
      keycloakMock.stop();
    }
  }

  @Before
  public void setUp() {
    // .alwaysDo(print())
    mockMvc = MockMvcBuilders.webAppContextSetup(context).apply(springSecurity()).build();
  }

  @Test
  public void getUserProfile() throws Exception {
    String accessToken = obtainMockAccessToken("room01");
    MvcResult result =
        mockMvc
            .perform(
                MockMvcRequestBuilders.request(HttpMethod.GET, "/user/profile")
                    .header(HttpHeaders.AUTHORIZATION, accessToken)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andReturn();
    String resultString = result.getResponse().getContentAsString();
    assertNotNull(resultString);
  }

  private String obtainMockAccessToken(String username) {
    Instant now = Instant.now();
    int i = (int) (now.getEpochSecond() / 1000);

    String accessToken =
        keycloakMock.getAccessToken(
            TokenConfig.aTokenConfig()
                .withAuthenticationTime(Instant.ofEpochSecond(i))
                .withPreferredUsername(username)
                .withRealmRole("app_user")
                .withResourceRole("ultrasound_api_service", "ultrasound-user")
                .build());

    return String.format("Bearer %s", accessToken);
  }
}
