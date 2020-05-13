package com.github.dantin.cubic.api.ultrasound.service.impl;

import com.github.dantin.cubic.api.ultrasound.service.RoomService;
import com.github.dantin.cubic.protocol.room.Route;
import com.github.dantin.cubic.protocol.room.RoutePage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
public class RoomServiceImpl implements RoomService {
  private static final Logger LOGGER = LoggerFactory.getLogger(RoomServiceImpl.class);

  private final RestTemplate restTemplate;

  public RoomServiceImpl(@Qualifier("clusterClient") RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  @Override
  public RoutePage listRoomByPage(int pageNumber, int pageSize) {
    LOGGER.info("list room by page, page number {}, size {}", pageNumber, pageSize);
    HttpHeaders headers = new HttpHeaders();
    headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
    HttpEntity<String> entity = new HttpEntity<>(headers);
    UriComponentsBuilder uriBuilder =
        UriComponentsBuilder.fromHttpUrl("http://room-service/rooms")
            .queryParam("page_number", pageNumber)
            .queryParam("page_size", pageSize);

    ResponseEntity<RoutePage> response =
        restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.GET, entity, RoutePage.class);
    if (!response.getStatusCode().is2xxSuccessful()) {
      throw new RuntimeException("fail to list room by invoking room-service");
    }

    return response.getBody();
  }

  @Override
  public Route getRoom(String username) {
    LOGGER.info("load room by user '{}'", username);
    HttpHeaders headers = new HttpHeaders();
    headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
    HttpEntity<String> entity = new HttpEntity<>(headers);
    String url = String.format("http://room-service/rooms/%s", username);

    ResponseEntity<Route> response =
        restTemplate.exchange(url, HttpMethod.GET, entity, Route.class);
    if (!response.getStatusCode().is2xxSuccessful()) {
      throw new RuntimeException("fail to load room by invoking room-service");
    }

    return response.getBody();
  }
}
