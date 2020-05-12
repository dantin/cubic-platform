package com.github.dantin.cubic.protocol.room;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@JsonDeserialize(builder = Route.Builder.class)
public class Route {

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

  public static Builder copyOf(Route o) {
    Builder builder = new Builder();
    builder.id = o.id;
    builder.name = o.name;
    return builder;
  }

  @JsonGetter("id")
  public String getId() {
    return id;
  }

  @JsonGetter("room")
  public String getName() {
    return name;
  }

  @JsonGetter("streams")
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

    @JsonSetter("id")
    public Builder id(String id) {
      this.id = id;
      return this;
    }

    @JsonSetter("room")
    public Builder name(String name) {
      this.name = name;
      return this;
    }

    @JsonSetter("streams")
    public Builder streams(List<Stream> streams) {
      this.streams = streams;
      return this;
    }

    public Builder addStream(Stream stream) {
      if (Objects.nonNull(stream)) {
        this.streams.add(stream);
      }
      return this;
    }

    @Override
    public Route build() {
      return new Route(this);
    }
  }
}
