package com.github.dantin.cubic.room.entity.model;

import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;
import java.util.Date;
import java.util.List;

/** Room is a model class that contains room information. */
public class Room {

  private String id;

  private String name;

  private Date createAt;

  private List<Stream> streams;

  public Room() {}

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public Date getCreateAt() {
    return createAt;
  }

  public void setCreateAt(Date createAt) {
    this.createAt = createAt;
  }

  public void setStreams(List<Stream> streams) {
    this.streams = streams;
  }

  public List<Stream> getStreams() {
    return streams;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof Room)) {
      return false;
    }
    Room room = (Room) o;
    return Objects.equal(id, room.id)
        && Objects.equal(name, room.name)
        && Objects.equal(createAt, room.createAt);
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(id, name, createAt);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("id", id)
        .add("name", name)
        .add("createAt", createAt)
        .toString();
  }
}
