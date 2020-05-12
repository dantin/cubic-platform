package com.github.dantin.cubic.api.ultrasound.service;

import com.github.dantin.cubic.protocol.Pagination;
import com.github.dantin.cubic.protocol.room.Route;

public interface RoomService {

  Pagination<Route> listRoomByPage(int pageNumber, int pageSize);
}
