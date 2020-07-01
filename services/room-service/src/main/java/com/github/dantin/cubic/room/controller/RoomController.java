package com.github.dantin.cubic.room.controller;

import com.github.dantin.cubic.base.exception.BusinessException;
import com.github.dantin.cubic.protocol.SearchCriteria;
import com.github.dantin.cubic.protocol.room.Route;
import com.github.dantin.cubic.protocol.room.RoutePage;
import com.github.dantin.cubic.protocol.room.Stream;
import com.github.dantin.cubic.room.entity.model.Room;
import com.github.dantin.cubic.room.entity.model.RoomAllocation;
import com.github.dantin.cubic.room.service.RoomAllocationService;
import com.github.dantin.cubic.room.service.RoomService;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rooms")
public class RoomController {

  private static final Logger LOGGER = LoggerFactory.getLogger(RoomController.class);

  private final RoomService roomService;
  private final RoomAllocationService roomAllocationService;

  public RoomController(RoomService roomService, RoomAllocationService roomAllocationService) {
    this.roomService = roomService;
    this.roomAllocationService = roomAllocationService;
  }

  @GetMapping
  public ResponseEntity<RoutePage> listRooms(
      @RequestParam(value = "n", defaultValue = "1", required = false) int number,
      @RequestParam(value = "s", defaultValue = "8", required = false) int size) {
    LOGGER.info("list room by page, page number {}, size {}", number, size);

    PageInfo<Room> roomsByPage =
        roomService.listRooms(SearchCriteria.builder().pageNumber(number).pageSize(size).build());

    LOGGER.info("build room pagination");
    RoutePage.Builder builder =
        RoutePage.builder()
            .pages(roomsByPage.getPages())
            .page(roomsByPage.getPageNum())
            .total(roomsByPage.getTotal())
            .hasPrevious(roomsByPage.isHasPreviousPage())
            .hasNext(roomsByPage.isHasNextPage());

    roomsByPage.getList().forEach(room -> builder.addRoute(buildRoute(room)));
    return ResponseEntity.ok(builder.build());
  }

  @GetMapping("/{username}")
  public ResponseEntity<Route> getRoom(@PathVariable("username") String username) {
    LOGGER.info("retrieve room information for user '{}'", username);

    try {
      RoomAllocation roomAllocation = roomAllocationService.getRoomAllocationByUsername(username);

      LOGGER.info("room '{}' is bind to user '{}'", roomAllocation.getRoomId(), username);

      Room room = roomService.getRoomById(roomAllocation.getRoomId());

      LOGGER.info("build room");
      return ResponseEntity.ok(buildRoute(room));
    } catch (BusinessException e) {
      LOGGER.warn("fail to retrieve room information", e);
      return ResponseEntity.notFound().build();
    }
  }

  private Route buildRoute(Room room) {
    Route.Builder builder = Route.builder().id(room.getId()).name(room.getName());
    room.getStreams()
        .forEach(
            x ->
                builder.addStream(
                    Stream.builder()
                        .type(x.getType())
                        .uri(x.getUri())
                        .scope(x.getScope())
                        .build()));
    return builder.build();
  }
}
