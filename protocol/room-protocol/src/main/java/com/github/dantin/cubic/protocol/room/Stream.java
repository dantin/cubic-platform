package com.github.dantin.cubic.protocol.room;

import com.fasterxml.jackson.annotation.JsonGetter;

public class Stream {
  private final String type;
  private final String uri;
  private final String role;

  Stream(Builder builder) {
    this.type = builder.type;
    this.uri = builder.uri;
    this.role = builder.role;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter("type")
  public String getType() {
    return type;
  }

  @JsonGetter("uri")
  public String getUri() {
    return uri;
  }

  public static final class Builder implements com.github.dantin.cubic.base.Builder<Stream> {
    private String type;
    private String uri;
    private String role;

    Builder() {}

    public Builder type(String type) {
      this.type = type;
      return this;
    }

    public Builder uri(String uri) {
      this.uri = uri;
      return this;
    }

    public Builder role(String role) {
      this.role = role;
      return this;
    }

    @Override
    public Stream build() {
      return new Stream(this);
    }
  }
}
