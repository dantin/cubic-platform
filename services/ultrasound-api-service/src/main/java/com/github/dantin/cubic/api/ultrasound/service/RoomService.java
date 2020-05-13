package com.github.dantin.cubic.api.ultrasound.service;

import com.github.dantin.cubic.protocol.room.Route;
import com.github.dantin.cubic.protocol.room.RoutePage;

public interface RoomService {

  RoutePage listRoomByPage(int pageNumber, int pageSize);

  Route getRoom(String username);
}
