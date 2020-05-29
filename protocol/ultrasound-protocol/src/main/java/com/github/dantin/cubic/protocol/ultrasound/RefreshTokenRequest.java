package com.github.dantin.cubic.protocol.ultrasound;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.common.base.MoreObjects;

public class RefreshTokenRequest {

  @JsonProperty("refresh_token")
  private String refreshToken;

  public String getRefreshToken() {
    return refreshToken;
  }

  public void setRefreshToken(String refreshToken) {
    this.refreshToken = refreshToken;
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this).add("refreshToken", refreshToken).toString();
  }
}
