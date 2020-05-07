package com.github.dantin.cubic.shm.remote;

import com.github.dantin.cubic.shm.config.MediaServerConfig;
import com.github.dantin.cubic.shm.model.protocol.AuthenticationRequest;
import com.github.dantin.cubic.shm.model.protocol.AuthenticationResponse;
import com.github.dantin.cubic.shm.model.protocol.ListRouteResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.util.DigestUtils;
import org.springframework.web.client.RestTemplate;

@Component
@EnableConfigurationProperties(MediaServerConfig.class)
public class MediaServiceClient {
  private static final Logger LOGGER = LoggerFactory.getLogger(MediaServiceClient.class);

  public static final String AUTH_PATH = "/user/login";

  private final MediaServerConfig mediaServerConfig;
  private final RestTemplate restTemplate;

  public MediaServiceClient(MediaServerConfig mediaServerConfig, RestTemplate restTemplate) {
    this.mediaServerConfig = mediaServerConfig;
    this.restTemplate = restTemplate;
  }

  public String getToken() {
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("get remote authentication token");
    }
    AuthenticationResponse authenticationResponse =
        restTemplate.postForObject(
            String.format("%s%s", mediaServerConfig.getBaseUrl(), AUTH_PATH),
            AuthenticationRequest.builder(
                    mediaServerConfig.getUsername(),
                    DigestUtils.md5DigestAsHex(mediaServerConfig.getPassword().getBytes()))
                .build(),
            AuthenticationResponse.class);
    return Objects.requireNonNull(authenticationResponse).getContent().getApi();
  }

  public List<String> listRoute() {
    if (LOGGER.isDebugEnabled()) {
      LOGGER.info("retrieve remote routes");
    }
    ListRouteResponse routeListResp =
        restTemplate.getForObject(
            String.format("%s/route/list", mediaServerConfig.getBaseUrl()),
            ListRouteResponse.class);
    List<String> names = new ArrayList<>();
    Objects.requireNonNull(routeListResp).getSources().forEach(obj -> names.add(obj.getName()));
    return names;
  }
}
