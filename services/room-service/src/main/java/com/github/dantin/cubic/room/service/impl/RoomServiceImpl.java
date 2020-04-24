package com.github.dantin.cubic.room.service.impl;

import com.github.dantin.cubic.base.CollectionsHelper;
import com.github.dantin.cubic.protocol.SearchCriteria;
import com.github.dantin.cubic.room.entity.model.Room;
import com.github.dantin.cubic.room.entity.model.Stream;
import com.github.dantin.cubic.room.repository.RoomMapper;
import com.github.dantin.cubic.room.repository.StreamMapper;
import com.github.dantin.cubic.room.service.RoomService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@CacheConfig(cacheNames = "roomCache")
public class RoomServiceImpl implements RoomService {

  private static final Logger LOGGER = LoggerFactory.getLogger(RoomServiceImpl.class);

  private final RoomMapper roomMapper;
  private final StreamMapper streamMapper;

  public RoomServiceImpl(RoomMapper roomMapper, StreamMapper streamMapper) {
    this.roomMapper = roomMapper;
    this.streamMapper = streamMapper;
  }

  @Transactional(readOnly = true)
  @Override
  public PageInfo<Room> listRooms(SearchCriteria criteria) {
    LOGGER.info("find room by page, number {}, size {}", criteria.getNumber(), criteria.getSize());
    PageHelper.startPage(criteria.getNumber(), criteria.getSize());
    List<Room> rooms = roomMapper.list();
    PageInfo<Room> page = new PageInfo<>(rooms);

    Map<String, Room> roomMap = rooms.stream().collect(Collectors.toMap(Room::getId, x -> x));
    List<String> roomIds = new ArrayList<>(roomMap.keySet());
    LOGGER.debug("find all streams of rooms whose id in {}", roomIds);
    List<Stream> streams = streamMapper.findAllByRoomIds(roomIds);

    LOGGER.debug("bind room and stream");
    Map<String, List<Stream>> streamMap =
        rooms.stream().collect(Collectors.toMap(Room::getId, x -> new ArrayList<>()));
    streams.forEach(x -> streamMap.get(x.getRoomId()).add(x));
    streamMap.forEach(
        (key, val) -> {
          Room room = roomMap.get(key);
          room.setStreams(val);
        });

    return page;
  }

  @Transactional(readOnly = true)
  @Cacheable(key = "#id")
  @Override
  public Room getRoomById(String id) {
    Room room = roomMapper.findByRoomId(id);
    if (Objects.isNull(room)) {
      throw new RuntimeException("no room found where id=" + id);
    }
    List<Stream> streams =
        streamMapper.findAllByRoomIds(new ArrayList<>(CollectionsHelper.listOf(room.getId())));
    room.setStreams(streams);

    return room;
  }
}
