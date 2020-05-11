package com.github.dantin.cubic.protocol.room;

import com.fasterxml.jackson.annotation.JsonGetter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Route {

  private final String id;
  private final String name;
  private final List<Stream> streams;

  Route(Builder builder) {
    this.id = builder.id;
    this.name = builder.name;
    this.streams = builder.streams;
  }

  public static Builder builder() {
    return new Builder();
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

  public static final class Builder implements com.github.dantin.cubic.base.Builder<Route> {
    private String id;
    private String name;
    private List<Stream> streams;

    Builder() {
      this.streams = new ArrayList<>();
    }

    public Builder id(String id) {
      this.id = id;
      return this;
    }

    public Builder name(String name) {
      this.name = name;
      return this;
    }

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
