package com.github.dantin.cubic.protocol.room;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;

@JsonDeserialize(builder = Stream.Builder.class)
public class Stream {
  private final String type;
  private final String uri;
  private final String role;

  private Stream(Builder builder) {
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

  @JsonGetter("role")
  public String getRole() {
    return role;
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder implements com.github.dantin.cubic.base.Builder<Stream> {
    private String type;
    private String uri;
    private String role;

    Builder() {}

    @JsonSetter("type")
    public Builder type(String type) {
      this.type = type;
      return this;
    }

    @JsonSetter("uri")
    public Builder uri(String uri) {
      this.uri = uri;
      return this;
    }

    @JsonSetter("role")
    public Builder role(String role) {
      this.role = role;
      return this;
    }

    @Override
    public Stream build() {
      return new Stream(this);
    }
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(type, uri, role);
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj) {
      return true;
    }
    if (!(obj instanceof Stream)) {
      return false;
    }
    Stream o = (Stream) obj;
    return Objects.equal(type, o.type) && Objects.equal(uri, o.uri) && Objects.equal(role, o.role);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("type", type)
        .add("uri", uri)
        .add("role", role)
        .toString();
  }
}
