package com.github.dantin.cubic.api.ultrasound;

import static org.junit.Assert.assertNotNull;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.httpBasic;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.apache.commons.lang3.StringUtils;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.json.JacksonJsonParser;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
@ActiveProfiles("test")
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
@Ignore
public class UltrasoundServerIntegrationTest {

  @Autowired private WebApplicationContext context;

  @Autowired private MockMvc mockMvc;

  @Test
  public void getUserProfile() throws Exception {
    String accessToken = obtainAccessToken("dummy_user", "password");
    MvcResult result =
        mockMvc
            .perform(
                get("/user/profile")
                    .header(HttpHeaders.AUTHORIZATION, accessToken)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andReturn();
    String resultString = result.getResponse().getContentAsString();
    assertNotNull(resultString);
  }

  private String obtainAccessToken(String username, String password) throws Exception {
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("grant_type", "password");
    params.add("username", username);
    params.add("password", password);

    ResultActions result =
        mockMvc
            .perform(
                post("/oauth/token")
                    .params(params)
                    .with(httpBasic("dummy_client", "password"))
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk());

    String resultString = result.andReturn().getResponse().getContentAsString();

    JacksonJsonParser jsonParser = new JacksonJsonParser();
    String accessToken = jsonParser.parseMap(resultString).get("access_token").toString();
    String tokenType = jsonParser.parseMap(resultString).get("token_type").toString();
    return String.format("%s %s", StringUtils.capitalize(tokenType), accessToken);
  }
}
