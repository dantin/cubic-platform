package com.github.dantin.cubic.protocol.room;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;

@JsonDeserialize(builder = Stream.Builder.class)
public class Stream {
  private static final String TYPE_FIELD = "type";
  private static final String URI_FIELD = "uri";
  private static final String SCOPE_FIELD = "scope";

  private final String type;
  private final String uri;
  private final String scope;

  private Stream(Builder builder) {
    this.type = builder.type;
    this.uri = builder.uri;
    this.scope = builder.scope;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter(TYPE_FIELD)
  public String getType() {
    return type;
  }

  @JsonGetter(URI_FIELD)
  public String getUri() {
    return uri;
  }

  @JsonGetter(SCOPE_FIELD)
  public String getScope() {
    return scope;
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder implements com.github.dantin.cubic.base.Builder<Stream> {
    private String type;
    private String uri;
    private String scope;

    Builder() {}

    @JsonSetter(TYPE_FIELD)
    public Builder type(String type) {
      this.type = type;
      return this;
    }

    @JsonSetter(URI_FIELD)
    public Builder uri(String uri) {
      this.uri = uri;
      return this;
    }

    @JsonSetter(SCOPE_FIELD)
    public Builder scope(String scope) {
      this.scope = scope;
      return this;
    }

    @Override
    public Stream build() {
      return new Stream(this);
    }
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(type, uri, scope);
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
    return Objects.equal(type, o.type)
        && Objects.equal(uri, o.uri)
        && Objects.equal(scope, o.scope);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add(TYPE_FIELD, type)
        .add(URI_FIELD, uri)
        .add(SCOPE_FIELD, scope)
        .toString();
  }
}
