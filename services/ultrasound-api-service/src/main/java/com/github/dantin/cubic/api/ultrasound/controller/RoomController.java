package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.api.ultrasound.service.RoomService;
import com.github.dantin.cubic.base.exception.BusinessException;
import com.github.dantin.cubic.protocol.Pagination;
import com.github.dantin.cubic.protocol.room.Route;
import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/room")
public class RoomController extends BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(RoomController.class);

  private final RoomService roomService;

  public RoomController(HttpServletRequest request, RoomService roomService) {
    super(request);
    this.roomService = roomService;
  }

  @GetMapping("/list")
  @RolesAllowed({"ultrasound-admin", "ultrasound-root"})
  public ResponseEntity<Pagination<Route>> listRoom(
      @RequestParam(value = "n", defaultValue = "1", required = false) int number,
      @RequestParam(value = "s", defaultValue = "8", required = false) int size) {
    String username = super.getUsername();
    LOGGER.info("list room by page triggered by '{}'", username);

    try {
      Pagination<Route> rooms = roomService.listRoomByPage(number, size);
      return ResponseEntity.ok(rooms);
    } catch (BusinessException e) {
      LOGGER.warn("list room by page failed", e);
      return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).build();
    }
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
