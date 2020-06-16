package com.github.dantin.cubic.protocol.ultrasound;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.google.common.base.MoreObjects;

@JsonDeserialize(builder = LoginRequest.Builder.class)
public class LoginRequest {

  private static final String USERNAME_FIELD = "username";
  private static final String PASSWORD_FIELD = "password";

  private final String username;
  private final String password;

  private LoginRequest(Builder builder) {
    this.username = builder.username;
    this.password = builder.password;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter(USERNAME_FIELD)
  public String getUsername() {
    return username;
  }

  @JsonGetter(PASSWORD_FIELD)
  public String getPassword() {
    return password;
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder implements com.github.dantin.cubic.base.Builder<LoginRequest> {

    private String username;
    private String password;

    private Builder() {}

    @JsonSetter(USERNAME_FIELD)
    public Builder username(String username) {
      if (java.util.Objects.nonNull(username)) {
        this.username = username;
      }
      return this;
    }

    @JsonSetter(PASSWORD_FIELD)
    public Builder password(String password) {
      if (java.util.Objects.nonNull(password)) {
        this.password = password;
      }
      return this;
    }

    @Override
    public LoginRequest build() {
      return new LoginRequest(this);
    }
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .add("username", username)
        .add("password", password)
        .toString();
  }
}
