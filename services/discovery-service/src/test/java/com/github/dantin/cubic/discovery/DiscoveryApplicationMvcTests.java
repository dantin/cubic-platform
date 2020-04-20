package com.github.dantin.cubic.discovery;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
public class DiscoveryApplicationMvcTests {
  @LocalServerPort private int port;

  @Test
  public void healthCheck() {
    ResponseEntity<String> response =
        new TestRestTemplate()
            .getForEntity("http://localhost:" + port + "/actuator/health", String.class);
    assertEquals(HttpStatus.OK, response.getStatusCode());
  }
}
