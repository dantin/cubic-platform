package com.github.dantin.cubic.room.service.impl;

import com.github.dantin.cubic.base.exception.BusinessException;
import com.github.dantin.cubic.room.entity.model.RoomAllocation;
import com.github.dantin.cubic.room.repository.RoomAllocationMapper;
import com.github.dantin.cubic.room.service.RoomAllocationService;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@CacheConfig(cacheNames = "roomAllocationCache")
public class RoomAllocationServiceImpl implements RoomAllocationService {

  private static final Logger LOGGER = LoggerFactory.getLogger(RoomAllocationServiceImpl.class);

  private final RoomAllocationMapper roomAllocationMapper;

  public RoomAllocationServiceImpl(RoomAllocationMapper roomAllocationMapper) {
    this.roomAllocationMapper = roomAllocationMapper;
  }

  @Transactional(readOnly = true)
  @Cacheable(key = "#username")
  @Override
  public RoomAllocation getRoomAllocationByUsername(String username) {
    RoomAllocation roomAllocation = roomAllocationMapper.findByUsername(username);
    if (Objects.isNull(roomAllocation)) {
      throw new BusinessException(
          String.format("user '%s' doesn't have room allocation", username));
    }
    return roomAllocation;
  }
}
