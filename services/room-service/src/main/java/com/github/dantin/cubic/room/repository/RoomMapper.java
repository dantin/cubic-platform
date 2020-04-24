package com.github.dantin.cubic.room.repository;

import com.github.dantin.cubic.room.entity.model.Room;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface RoomMapper {

  List<Room> list();

  Room findByRoomId(@Param("room_id") String roomId);
}
