package com.github.dantin.cubic.protocol.room;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;

@JsonDeserialize(builder = Route.Builder.class)
public class Route {

  private static final String ID_FIELD = "id";
  private static final String ROOM_FIELD = "room";
  private static final String STREAMS_FIELD = "streams";

  private final String id;
  private final String name;
  private final List<Stream> streams;

  private Route(Builder builder) {
    this.id = builder.id;
    this.name = builder.name;
    this.streams = builder.streams;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter(ID_FIELD)
  public String getId() {
    return id;
  }

  @JsonGetter(ROOM_FIELD)
  public String getName() {
    return name;
  }

  @JsonGetter(STREAMS_FIELD)
  public List<Stream> getStreams() {
    return streams;
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder implements com.github.dantin.cubic.base.Builder<Route> {
    private String id;
    private String name;
    private List<Stream> streams;

    Builder() {
      this.streams = new ArrayList<>();
    }

    @JsonSetter(ID_FIELD)
    public Builder id(String id) {
      this.id = id;
      return this;
    }

    @JsonSetter(ROOM_FIELD)
    public Builder name(String name) {
      this.name = name;
      return this;
    }

    @JsonSetter(STREAMS_FIELD)
    public Builder streams(List<Stream> streams) {
      this.streams = streams;
      return this;
    }

    public Builder addStream(Stream stream) {
      if (!java.util.Objects.isNull(stream)) {
        this.streams.add(stream);
      }
      return this;
    }

    @Override
    public Route build() {
      return new Route(this);
    }
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(id, name, streams);
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj) {
      return true;
    }
    if (!(obj instanceof Route)) {
      return false;
    }
    Route o = (Route) obj;
    return Objects.equal(id, o.id)
        && Objects.equal(name, o.name)
        && Objects.equal(streams, o.streams);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("id", id)
        .add("name", name)
        .add("stream", streams)
        .toString();
  }
}
