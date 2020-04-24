package com.github.dantin.cubic.room;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
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

  private RedisServer redisServer;

  @Before
  public void setUp() {
    this.redisServer = RedisServer.builder().port(6379).setting("requirepass password").build();
    this.redisServer.start();
  }

  @After
  public void tearDown() {
    this.redisServer.stop();
  }

  @Test
  public void basicCrud() throws Exception {
    getRoom("11");
  }

  private void getRoom(String roomId) throws Exception {
    ResultActions result =
        mockMvc
            .perform(
                get("/rooms/" + roomId)
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk());
  }
}
