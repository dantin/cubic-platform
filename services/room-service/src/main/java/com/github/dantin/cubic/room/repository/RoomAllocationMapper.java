package com.github.dantin.cubic.room.repository;

import com.github.dantin.cubic.room.entity.model.RoomAllocation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface RoomAllocationMapper {

  RoomAllocation findByUsername(@Param("username") String username);
}
