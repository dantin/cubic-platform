package com.github.dantin.cubic.api.ultrasound;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.client.match.MockRestRequestMatchers.method;
import static org.springframework.test.web.client.match.MockRestRequestMatchers.requestTo;
import static org.springframework.test.web.client.response.MockRestResponseCreators.withStatus;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.protocol.ultrasound.LoginRequest;
import com.tngtech.keycloakmock.api.KeycloakVerificationMock;
import com.tngtech.keycloakmock.api.TokenConfig;
import java.net.URI;
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
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.client.ExpectedCount;
import org.springframework.test.web.client.MockRestServiceServer;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
@SpringBootTest(
    value = {"eureka.client.enabled:false"},
    webEnvironment = WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
public class UltrasoundApiMvcTest {

  private static KeycloakVerificationMock keycloakMock;

  private ObjectMapper objectMapper = new ObjectMapper();
  private MockRestServiceServer mockServer;

  @Autowired private WebApplicationContext context;

  @Autowired private MockMvc mockMvc;

  @Autowired private RestTemplate restTemplate;

  @Value("${keycloak.resource}")
  private String clientId;

  @Value("${keycloak.credentials.secret}")
  private String clientSecret;

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
  public void init() {
    mockServer = MockRestServiceServer.createServer(restTemplate);
  }

  @Before
  public void setUp() {
    // .alwaysDo(print())
    mockMvc = MockMvcBuilders.webAppContextSetup(context).apply(springSecurity()).build();
  }

  @Test
  public void doLogin_thenSuccess() throws Exception {
    mockServer
        .expect(
            ExpectedCount.once(),
            requestTo(
                new URI(
                    "http://localhost:8083/auth/realms/ultrasound/protocol/openid-connect/token")))
        .andExpect(method(HttpMethod.POST))
        .andRespond(
            withStatus(HttpStatus.OK).contentType(MediaType.APPLICATION_JSON).body("success"));
    LoginRequest loginRequest = new LoginRequest();
    loginRequest.setUsername("room01");
    loginRequest.setPassword("password");
    MvcResult result =
        mockMvc
            .perform(
                MockMvcRequestBuilders.post("/auth/login")
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON)
                    .content(asJsonString(loginRequest)))
            .andExpect(status().isOk())
            .andReturn();
    String resultString = result.getResponse().getContentAsString();
    assertEquals("success", resultString);
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

  private String asJsonString(final Object obj) {
    try {
      return objectMapper.writeValueAsString(obj);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
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
