package com.github.dantin.cubic.room;

import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.json.JacksonJsonParser;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlConfig;
import org.springframework.test.context.jdbc.SqlConfig.TransactionMode;
import org.springframework.test.context.jdbc.SqlGroup;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import redis.embedded.RedisServer;

@RunWith(SpringRunner.class)
@SpringBootTest(
    value = {"eureka.client.enabled:false"},
    webEnvironment = WebEnvironment.RANDOM_PORT)
@SqlGroup({
  @Sql(scripts = "/schema.sql", config = @SqlConfig(transactionMode = TransactionMode.ISOLATED)),
  @Sql(scripts = "/init-data.sql")
})
@ActiveProfiles("test")
@AutoConfigureMockMvc
public class RoomApplicationMvcTest {

  @Autowired private MockMvc mockMvc;

  private static RedisServer redisServer;

  // @BeforeClass
  public static void setUp() {
    redisServer = RedisServer.builder().port(6379).setting("requirepass password").build();
    redisServer.start();
  }

  // @AfterClass
  public static void tearDown() {
    redisServer.stop();
  }

  @Test
  public void findNotExistsRoom_thenNotFound() throws Exception {
    String username = "noExists";

    ResultActions result =
        mockMvc
            .perform(
                get("/rooms/" + username)
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNotFound());
  }

  @Test
  public void findExistsRoom_thenOk() throws Exception {
    String username = "room01";

    ResultActions result =
        mockMvc
            .perform(
                get("/rooms/" + username)
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk());

    String resultString = result.andReturn().getResponse().getContentAsString();

    JacksonJsonParser jsonParser = new JacksonJsonParser();
    String name = jsonParser.parseMap(resultString).get("name").toString();
    assertEquals("Room-01", name);
  }

  @Test
  public void listRoomByPages_thenOk() throws Exception {
    int size = listRoom(4);
    assertEquals(4, size);

    size = listRoom(2);
    assertEquals(2, size);
  }

  private int listRoom(int pageSize) throws Exception {
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("n", "1");
    params.add("s", String.valueOf(pageSize));

    ResultActions result =
        mockMvc
            .perform(
                get("/rooms")
                    .params(params)
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk());

    String resultString = result.andReturn().getResponse().getContentAsString();

    JacksonJsonParser jsonParser = new JacksonJsonParser();
    String size = jsonParser.parseMap(resultString).get("size").toString();

    return Integer.parseInt(size);
  }
}
