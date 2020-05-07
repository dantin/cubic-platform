package com.github.dantin.cubic.room.service;

import com.github.dantin.cubic.room.entity.model.RoomAllocation;

public interface RoomAllocationService {

  RoomAllocation getRoomAllocationByUsername(String username);
}
