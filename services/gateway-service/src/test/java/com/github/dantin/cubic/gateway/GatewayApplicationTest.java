package com.github.dantin.cubic.gateway;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(
    value = {"eureka.client.enabled:false"},
    webEnvironment = WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
@Ignore
public class GatewayApplicationTest {

  @Test
  public void contextLoads() {
    // just do context loading
  }
}
