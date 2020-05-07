package com.github.dantin.cubic.shm.model.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;

@JsonDeserialize(builder = AuthenticationResponse.Builder.class)
public final class AuthenticationResponse extends SecurityResponse {

  private Content content;

  AuthenticationResponse(Builder builder) {
    super(builder);
    this.content = builder.content;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter("message")
  public Content getContent() {
    return content;
  }

  @JsonDeserialize(builder = Content.Builder.class)
  public static class Content {

    private final String authentication;

    private final String api;

    private Content(Builder builder) {
      this.authentication = builder.authentication;
      this.api = builder.api;
    }

    public static Builder builder() {
      return new Builder();
    }

    @JsonGetter("auth")
    public String getAuthentication() {
      return authentication;
    }

    @JsonGetter("api")
    public String getApi() {
      return api;
    }

    @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
    public static final class Builder implements com.github.dantin.cubic.base.Builder<Content> {

      private String authentication;
      private String api;

      @JsonSetter("auth")
      public Builder authentication(String authentication) {
        this.authentication = authentication;
        return this;
      }

      @JsonSetter("api")
      public Builder api(String api) {
        this.api = api;
        return this;
      }

      @Override
      public Content build() {
        return new Content(this);
      }
    }
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder
      extends SecurityResponseBuilder<Builder, AuthenticationResponse> {

    private Content content;

    private Builder() {}

    @JsonSetter("message")
    public Builder content(Content content) {
      this.content = content;
      return this;
    }

    @Override
    public AuthenticationResponse build() {
      return new AuthenticationResponse(this);
    }
  }
}
