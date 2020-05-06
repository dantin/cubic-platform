package com.github.dantin.cubic.room.controller;

import com.github.dantin.cubic.protocol.SearchCriteria;
import com.github.dantin.cubic.room.entity.model.Room;
import com.github.dantin.cubic.room.entity.model.RoomAllocation;
import com.github.dantin.cubic.room.service.RoomAllocationService;
import com.github.dantin.cubic.room.service.RoomService;
import com.github.pagehelper.PageInfo;
import java.util.Objects;
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
  public ResponseEntity<PageInfo<Room>> listRooms(
      @RequestParam(value = "n", defaultValue = "1", required = false) int number,
      @RequestParam(value = "s", defaultValue = "8", required = false) int size) {
    LOGGER.info("list route, page number {}, size {}", number, size);

    PageInfo<Room> roomsByPage =
        roomService.listRooms(SearchCriteria.builder().pageNumber(number).pageSize(size).build());

    return ResponseEntity.ok(roomsByPage);
  }

  @GetMapping("/{userId}")
  public ResponseEntity<Room> getRoom(@PathVariable("userId") String userId) {
    LOGGER.info("get room info for user {}", userId);

    RoomAllocation roomAllocation = roomAllocationService.getRoomAllocationByUserId(userId);
    if (Objects.isNull(roomAllocation)) {
      return ResponseEntity.notFound().build();
    }
    LOGGER.info("found room {} is bind with user {}", roomAllocation.getRoomId(), userId);
    Room room = roomService.getRoomById(roomAllocation.getRoomId());

    return ResponseEntity.ok(room);
  }
}