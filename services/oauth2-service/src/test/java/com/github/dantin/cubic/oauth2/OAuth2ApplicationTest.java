package com.github.dantin.cubic.oauth2;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(
    classes = {OAuth2Application.class},
    webEnvironment = WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
public class OAuth2ApplicationTest {

  @Test
  public void contextLoads() {
    // just do context loading
  }
}
