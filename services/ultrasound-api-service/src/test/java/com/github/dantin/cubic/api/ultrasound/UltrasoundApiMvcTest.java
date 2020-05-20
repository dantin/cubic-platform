package com.github.dantin.cubic.api.ultrasound;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.api.ultrasound.service.RoomService;
import com.github.dantin.cubic.protocol.room.Device;
import com.github.dantin.cubic.protocol.room.Role;
import com.github.dantin.cubic.protocol.room.Route;
import com.github.dantin.cubic.protocol.room.RoutePage;
import com.github.dantin.cubic.protocol.room.Stream;
import com.github.dantin.cubic.protocol.ultrasound.LoginRequest;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import java.util.UUID;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
@SpringBootTest(
    value = {"eureka.client.enabled:false"},
    webEnvironment = WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
public class UltrasoundApiMvcTest {

  private final ObjectMapper MAPPER = new ObjectMapper();

  @Autowired private WebApplicationContext context;

  @Autowired private MockMvc mockMvc;

  @MockBean private RoomService roomServiceMock;

  @Value("${keycloak.resource}")
  private String clientId;

  @Value("${keycloak.credentials.secret}")
  private String clientSecret;

  @Before
  public void init() {
    // .alwaysDo(print())
    mockMvc = MockMvcBuilders.webAppContextSetup(context).apply(springSecurity()).build();
  }

  @Test
  public void doLogin_thenSuccess() throws Exception {
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
    assertNotNull(resultString);
  }

  @Test
  public void getRoom_thenSuccess() throws Exception {
    final String username = "room01";
    String accessToken = obtainMockAccessToken(username);

    // mock data
    Route.Builder builder = Route.builder().id("1").name("route 1");
    builder.addStream(
        Stream.builder()
            .role(Role.ADMIN.getAlias())
            .type(Device.CAMERA.getAlias())
            .uri("srt::" + UUID.randomUUID().toString())
            .build());
    builder.addStream(
        Stream.builder()
            .role(Role.ADMIN.getAlias())
            .type(Device.DEVICE.getAlias())
            .uri("srt::" + UUID.randomUUID().toString())
            .build());
    builder.addStream(
        Stream.builder()
            .role(Role.USER.getAlias())
            .type(Device.CAMERA.getAlias())
            .uri("srt::" + UUID.randomUUID().toString())
            .build());
    builder.addStream(
        Stream.builder()
            .role(Role.USER.getAlias())
            .type(Device.DEVICE.getAlias())
            .uri("srt::" + UUID.randomUUID().toString())
            .build());

    Route orig = builder.build();
    Mockito.when(roomServiceMock.getRoom(username)).thenReturn(orig);

    MvcResult result =
        mockMvc
            .perform(
                MockMvcRequestBuilders.request(HttpMethod.GET, "/room")
                    .header(HttpHeaders.AUTHORIZATION, accessToken)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andReturn();
    String jsonString = result.getResponse().getContentAsString();
    assertNotNull(jsonString);

    Route route = MAPPER.readValue(jsonString, Route.class);
    assertNotNull(route);
    assertThat(route.getId(), is(orig.getId()));
    assertThat(route.getName(), is(orig.getName()));
    assertEquals(2, route.getStreams().size());
  }

  @Test
  public void listRoomByPage_thenSuccess() throws Exception {
    String accessToken = obtainMockAccessToken("admin");
    listRoomByPage(accessToken, 1, 8, 10);
    listRoomByPage(accessToken, 2, 4, 4);
  }

  private void listRoomByPage(String accessToken, int page, int size, int pages) throws Exception {
    // mock data
    RoutePage.Builder builder = RoutePage.builder();
    builder.pages(pages).page(page).size(size);
    for (int i = 0; i < size; i++) {
      int id = page * size + i;
      Route.Builder route = Route.builder().id(String.valueOf(id)).name("route " + id);
      route.addStream(
          Stream.builder()
              .role(Role.ADMIN.getAlias())
              .type(Device.CAMERA.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.ADMIN.getAlias())
              .type(Device.DEVICE.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.USER.getAlias())
              .type(Device.CAMERA.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.USER.getAlias())
              .type(Device.DEVICE.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      builder.addRoute(route.build());
    }

    Mockito.when(roomServiceMock.listRoomByPage(page, size)).thenReturn(builder.build());

    LinkedMultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("n", String.valueOf(page));
    params.add("s", String.valueOf(size));
    MvcResult result =
        mockMvc
            .perform(
                MockMvcRequestBuilders.request(HttpMethod.GET, "/room/list")
                    .header(HttpHeaders.AUTHORIZATION, accessToken)
                    .accept(MediaType.APPLICATION_JSON)
                    .params(params))
            .andExpect(status().isOk())
            .andReturn();
    String jsonString = result.getResponse().getContentAsString();
    assertNotNull(jsonString);

    RoutePage routesByPage = MAPPER.readValue(jsonString, RoutePage.class);
    assertThat(routesByPage.getPages(), is(pages));
    assertThat(routesByPage.getPage(), is(page));
    assertThat(routesByPage.getRoutes().size(), is(size));
    for (Route route : routesByPage.getRoutes()) {
      assertNotNull(route);
      assertEquals(2, route.getStreams().size());
    }
  }

  @Test
  public void getUserProfile_thenSuccess() throws Exception {
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
      return MAPPER.writeValueAsString(obj);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  private String obtainMockAccessToken(String username) {
    String url = "http://localhost:9990/auth/realms/ultrasound/protocol/openid-connect/token";
    // obtain authentication url with custom code
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("client_id", clientId);
    params.add("client_secret", clientSecret);
    params.add("grant_type", "password");
    params.add("username", username);
    params.add("password", "password");

    Response response = RestAssured.given().formParams(params).post(url);

    return String.format("Bearer %s", response.jsonPath().getString("access_token"));
  }
}
