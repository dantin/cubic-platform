package com.github.dantin.cubic.user.entity.model;

import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;

/** Authority is a model class that contains authority information. */
public class Authority {

  private String username;

  private String authority;

  public Authority() {}

  public Authority(String username, String authority) {
    this.username = username;
    this.authority = authority;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getAuthority() {
    return authority;
  }

  public void setAuthority(String authority) {
    this.authority = authority;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof Authority)) {
      return false;
    }
    Authority authority = (Authority) o;
    return Objects.equal(username, authority.username)
        && Objects.equal(authority, authority.authority);
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(username, authority);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("username", username)
        .add("authority", authority)
        .toString();
  }
}
