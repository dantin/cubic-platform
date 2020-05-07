package com.github.dantin.cubic.shm.model.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;

@JsonDeserialize(builder = AuthenticationRequest.Builder.class)
public final class AuthenticationRequest {

  private final String username;

  private final String password;

  private AuthenticationRequest(Builder builder) {
    this.username = builder.username;
    this.password = builder.password;
  }

  public static Builder builder(String username, String password) {
    return new Builder().username(username).password(password);
  }

  @JsonGetter("username")
  public String getUsername() {
    return username;
  }

  @JsonGetter("passwd")
  public String getPassword() {
    return password;
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static class Builder
      implements com.github.dantin.cubic.base.Builder<AuthenticationRequest> {

    private String username;
    private String password;

    private Builder() {}

    @JsonSetter("username")
    public Builder username(String value) {
      this.username = value;
      return this;
    }

    @JsonSetter("passwd")
    public Builder password(String value) {
      this.password = value;
      return this;
    }

    @Override
    public AuthenticationRequest build() {
      return new AuthenticationRequest(this);
    }
  }
}
