package com.github.dantin.cubic.protocol.ultrasound;

import com.google.common.base.MoreObjects;

public class LoginRequest {

  private String username;
  private String password;

  public LoginRequest() {}

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .add("username", username)
        .add("password", password)
        .toString();
  }
}