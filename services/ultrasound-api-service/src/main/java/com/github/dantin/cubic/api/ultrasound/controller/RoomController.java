package com.github.dantin.cubic.api.ultrasound.controller;

import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/room")
public class RoomController extends BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(RoomController.class);

  public RoomController(HttpServletRequest request) {
    super(request);
  }

  @GetMapping("/list")
  @RolesAllowed({"ultrasound-admin", "ultrasound-root"})
  public ResponseEntity<String> listRoom(
      @RequestParam(value = "n", defaultValue = "1", required = false) int number,
      @RequestParam(value = "s", defaultValue = "8", required = false) int size) {
    LOGGER.info("list room by page, page number {}, size {}", number, size);

    return ResponseEntity.ok().build();
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
