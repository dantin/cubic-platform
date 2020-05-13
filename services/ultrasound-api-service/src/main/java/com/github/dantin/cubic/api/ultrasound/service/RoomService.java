package com.github.dantin.cubic.api.ultrasound.service;

import com.github.dantin.cubic.protocol.room.RoutePage;

public interface RoomService {

  RoutePage listRoomByPage(int pageNumber, int pageSize);
}
