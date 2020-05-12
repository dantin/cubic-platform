package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.protocol.Pagination;
import com.github.dantin.cubic.protocol.room.Route;
import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/room")
public class RoomController extends BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(RoomController.class);

  private final RestTemplate restTemplate;

  public RoomController(
      @Qualifier("clusterClient") RestTemplate restTemplate, HttpServletRequest request) {
    super(request);
    this.restTemplate = restTemplate;
  }

  @GetMapping("/list")
  @RolesAllowed({"ultrasound-admin", "ultrasound-root"})
  public ResponseEntity<Pagination<Route>> listRoom(
      @RequestParam(value = "n", defaultValue = "1", required = false) int number,
      @RequestParam(value = "s", defaultValue = "8", required = false) int size) {
    LOGGER.info("list room by page, page number {}, size {}", number, size);

    HttpHeaders headers = new HttpHeaders();
    headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
    HttpEntity<String> entity = new HttpEntity<>(headers);
    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("page_number", String.valueOf(number));
    params.add("page_size", String.valueOf(size));

    String username = super.getUsername();
    LOGGER.debug("triggered by '{}'", username);

    ResponseEntity<Pagination<Route>> routes =
        restTemplate.exchange(
            "http://room-service/rooms",
            HttpMethod.GET,
            entity,
            new ParameterizedTypeReference<Pagination<Route>>() {});
    if (!routes.getStatusCode().is2xxSuccessful()) {
      return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).build();
    }

    return routes;
  }

  @GetMapping
  @RolesAllowed({"ultrasound-user", "ultrasound-admin", "ultrasound-root"})
  public ResponseEntity<String> getRoom() {
    LOGGER.info("load room information");

    String username = super.getUsername();
    LOGGER.debug("found user '{}' in security context", username);

    return ResponseEntity.ok().build();
  }
}
