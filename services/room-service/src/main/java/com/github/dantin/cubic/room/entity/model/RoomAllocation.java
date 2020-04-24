package com.github.dantin.cubic.room.entity.model;

import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;

/** RoomAllocation is a model class that contains room and user binding information. */
public class RoomAllocation {

  private String userId;
  private String roomId;

  public RoomAllocation() {}

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getRoomId() {
    return roomId;
  }

  public void setRoomId(String roomId) {
    this.roomId = roomId;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof RoomAllocation)) {
      return false;
    }
    RoomAllocation roomAllocation = (RoomAllocation) o;
    return Objects.equal(userId, roomAllocation.userId)
        && Objects.equal(roomId, roomAllocation.roomId);
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(userId, roomId);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("userId", userId)
        .add("roomId", roomId)
        .toString();
  }
}
