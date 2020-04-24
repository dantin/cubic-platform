package com.github.dantin.cubic.room.repository;

import com.github.dantin.cubic.room.entity.model.Stream;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface StreamMapper {

  List<Stream> findAllByRoomIds(@Param("room_ids") List<String> ids);
}
