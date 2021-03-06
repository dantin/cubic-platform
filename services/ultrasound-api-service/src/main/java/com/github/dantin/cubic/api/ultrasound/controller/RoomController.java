package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.api.ultrasound.service.RoomService;
import com.github.dantin.cubic.protocol.ResponseResult;
import com.github.dantin.cubic.protocol.room.Route;
import com.github.dantin.cubic.protocol.room.RoutePage;
import com.github.dantin.cubic.protocol.room.Scope;
import java.util.stream.Collectors;
import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/room")
@ResponseResult
public class RoomController extends BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(RoomController.class);

  private final RoomService roomService;

  public RoomController(HttpServletRequest request, RoomService roomService) {
    super(request);
    this.roomService = roomService;
  }

  @GetMapping("/list")
  @RolesAllowed({"ultrasound-admin", "ultrasound-root"})
  public RoutePage listRoom(
      @RequestParam(value = "n", defaultValue = "1", required = false) int number,
      @RequestParam(value = "s", defaultValue = "8", required = false) int size) {
    LOGGER.info("list room by page");

    String username = super.getUsername();
    LOGGER.info("list room triggered by '{}'", username);

    RoutePage orig = roomService.listRoomByPage(number, size);
    RoutePage.Builder builder = RoutePage.builder().copyOf(orig);
    orig.getRoutes()
        .forEach(
            route -> {
              builder.addRoute(
                  Route.builder()
                      .name(route.getName())
                      .id(route.getId())
                      .streams(
                          route
                              .getStreams()
                              .stream()
                              .filter(s -> Scope.from(s.getScope()) == Scope.ADMIN)
                              .collect(Collectors.toList()))
                      .build());
            });
    return builder.build();
  }

  @GetMapping
  @RolesAllowed({"ultrasound-user", "ultrasound-admin", "ultrasound-root"})
  public Route getRoom() {
    LOGGER.info("load room");

    String username = super.getUsername();
    LOGGER.info("load room triggered by '{}'", username);

    Route orig = roomService.getRoom(username);
    Route.Builder builder =
        Route.builder()
            .id(orig.getId())
            .name(orig.getName())
            .streams(
                orig.getStreams()
                    .stream()
                    .filter(s -> Scope.from(s.getScope()) == Scope.USER)
                    .collect(Collectors.toList()));
    return builder.build();
  }

  @GetMapping("/qc")
  @RolesAllowed({"ultrasound-user", "ultrasound-root"})
  public Route getQcStream() {
    LOGGER.info("load room QC stream");

    String username = super.getUsername();
    LOGGER.info("load room QC stream triggered by '{}'", username);

    Route orig = roomService.getRoom(username);
    Route.Builder builder =
        Route.builder()
            .id(orig.getId())
            .name(orig.getName())
            .streams(
                orig.getStreams()
                    .stream()
                    .filter(s -> Scope.from(s.getScope()) == Scope.QC)
                    .collect(Collectors.toList()));
    return builder.build();
  }
}
