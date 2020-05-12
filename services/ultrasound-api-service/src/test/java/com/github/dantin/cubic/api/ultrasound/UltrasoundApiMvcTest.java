package com.github.dantin.cubic.api.ultrasound;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.client.match.MockRestRequestMatchers.method;
import static org.springframework.test.web.client.match.MockRestRequestMatchers.requestTo;
import static org.springframework.test.web.client.response.MockRestResponseCreators.withStatus;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.api.ultrasound.service.RoomService;
import com.github.dantin.cubic.protocol.Pagination;
import com.github.dantin.cubic.protocol.room.Route;
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
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.mock.mockito.MockBean;
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

  private final ObjectMapper objectMapper = new ObjectMapper();

  private MockRestServiceServer mockAuthServer;

  @Autowired private WebApplicationContext context;

  @Autowired private MockMvc mockMvc;

  @Qualifier("edgeClient")
  @Autowired
  private RestTemplate edgeClient;

  @MockBean private RoomService roomServiceMock;

  @BeforeClass
  public static void setUp() {
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
    mockAuthServer = MockRestServiceServer.createServer(edgeClient);
    // .alwaysDo(print())
    mockMvc = MockMvcBuilders.webAppContextSetup(context).apply(springSecurity()).build();
  }

  @Test
  public void doLogin_thenSuccess() throws Exception {
    final String mockResponseBody = "success";
    mockAuthServer
        .expect(
            ExpectedCount.once(),
            requestTo(
                new URI(
                    "http://localhost:8083/auth/realms/ultrasound/protocol/openid-connect/token")))
        .andExpect(method(HttpMethod.POST))
        .andRespond(
            withStatus(HttpStatus.OK)
                .contentType(MediaType.APPLICATION_JSON)
                .body(mockResponseBody));
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
    assertEquals(mockResponseBody, resultString);
  }

  @Test
  public void listRoom() throws Exception {
    String accessToken = obtainMockAccessToken("admin", "ultrasound-admin");
    Mockito.when(roomServiceMock.listRoomByPage(1, 8))
        .thenReturn(Pagination.<Route>builder().page(1).pages(8).build());

    MvcResult result =
        mockMvc
            .perform(
                MockMvcRequestBuilders.request(HttpMethod.GET, "/room/list")
                    .header(HttpHeaders.AUTHORIZATION, accessToken)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andReturn();
    String resultString = result.getResponse().getContentAsString();
    assertNotNull(resultString);
  }

  @Test
  public void getUserProfile() throws Exception {
    String accessToken = obtainMockAccessToken("room01", "ultrasound-user");
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

  private String obtainMockAccessToken(String username, String role) {
    Instant now = Instant.now();
    int i = (int) (now.getEpochSecond() / 1000);

    String accessToken =
        keycloakMock.getAccessToken(
            TokenConfig.aTokenConfig()
                .withAuthenticationTime(Instant.ofEpochSecond(i))
                .withPreferredUsername(username)
                .withRealmRole("app_user")
                .withResourceRole("ultrasound_api_service", role)
                .build());

    return String.format("Bearer %s", accessToken);
  }
}
