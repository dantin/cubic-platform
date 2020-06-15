package com.github.dantin.cubic.protocol.ultrasound;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.google.common.base.MoreObjects;

@JsonDeserialize(builder = Token.Builder.class)
public class Token {

  private static final String ACCESS_TOKEN_FIELD = "access_token";
  private static final String REFRESH_TOKEN_FIELD = "refresh_token";

  private final String accessToken;
  private final String refreshToken;

  private Token(Builder builder) {
    this.accessToken = builder.accessToken;
    this.refreshToken = builder.refreshToken;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter(ACCESS_TOKEN_FIELD)
  public String getAccessToken() {
    return accessToken;
  }

  @JsonGetter(REFRESH_TOKEN_FIELD)
  public String getRefreshToken() {
    return refreshToken;
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder implements com.github.dantin.cubic.base.Builder<Token> {

    private String accessToken;
    private String refreshToken;

    private Builder() {}

    @JsonSetter(ACCESS_TOKEN_FIELD)
    public Builder accessToken(String accessToken) {
      if (java.util.Objects.nonNull(accessToken)) {
        this.accessToken = accessToken;
      }
      return this;
    }

    @JsonSetter(REFRESH_TOKEN_FIELD)
    public Builder refreshToken(String refreshToken) {
      if (java.util.Objects.nonNull(refreshToken)) {
        this.refreshToken = refreshToken;
      }
      return this;
    }

    @Override
    public Token build() {
      return new Token(this);
    }
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .add("accessToken", accessToken)
        .add("refreshToken", refreshToken)
        .toString();
  }
}
