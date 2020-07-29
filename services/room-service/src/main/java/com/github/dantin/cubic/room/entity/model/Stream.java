package com.github.dantin.cubic.room.entity.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;
import com.google.common.base.Strings;
import java.util.Date;

/** Stream is a model class that contains binary stream information. */
public class Stream {

  private String id;

  private String type;

  private String scope;

  private String protocol;

  private String host;

  private Integer port;

  private String path;

  private Date createAt;

  private String roomId;

  public Stream() {}

  @JsonIgnore
  public String getUri() {
    if (Strings.isNullOrEmpty(this.path)) {
      return String.format("%s://%s:%d", protocol, host, port);
    }
    return String.format("%s://%s:%d/%s", protocol, host, port, path);
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getScope() {
    return scope;
  }

  public void setScope(String scope) {
    this.scope = scope;
  }

  public String getProtocol() {
    return protocol;
  }

  public void setProtocol(String protocol) {
    this.protocol = protocol;
  }

  public String getHost() {
    return host;
  }

  public void setHost(String host) {
    this.host = host;
  }

  public Integer getPort() {
    return port;
  }

  public void setPort(Integer port) {
    this.port = port;
  }

  public String getPath() {
    return path;
  }

  public void setPath(String path) {
    this.path = path;
  }

  public Date getCreateAt() {
    return createAt;
  }

  public void setCreateAt(Date createAt) {
    this.createAt = createAt;
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
    if (!(o instanceof Stream)) {
      return false;
    }
    Stream stream = (Stream) o;
    return Objects.equal(id, stream.id)
        && Objects.equal(type, stream.type)
        && Objects.equal(scope, stream.scope)
        && Objects.equal(protocol, stream.protocol)
        && Objects.equal(host, stream.host)
        && Objects.equal(port, stream.port)
        && Objects.equal(path, stream.path)
        && Objects.equal(createAt, stream.createAt)
        && Objects.equal(roomId, stream.roomId);
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(id, type, scope, protocol, host, port, path, createAt, roomId);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("id", id)
        .add("type", type)
        .add("scope", scope)
        .add("protocol", protocol)
        .add("host", host)
        .add("port", port)
        .add("path", path)
        .add("roomId", roomId)
        .add("createAt", createAt)
        .toString();
  }
}
