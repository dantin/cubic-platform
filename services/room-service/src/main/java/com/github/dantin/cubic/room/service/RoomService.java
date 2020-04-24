package com.github.dantin.cubic.room.service;

import com.github.dantin.cubic.protocol.SearchCriteria;
import com.github.dantin.cubic.room.entity.model.Room;
import com.github.pagehelper.PageInfo;

public interface RoomService {

  PageInfo<Room> listRooms(SearchCriteria criteria);

  Room getRoomById(String id);
}
