package com.github.dantin.cubic.user.entity.model;

import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;
import java.util.Date;

/** User is a model class that contains user information. */
public class User {

  private String id;

  private String username;

  private String password;

  private String role;

  private Date createAt;

  private Date updateAt;

  private Boolean enabled;

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

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

  public String getRole() {
    return role;
  }

  public void setRole(String role) {
    this.role = role;
  }

  public Date getCreateAt() {
    return createAt;
  }

  public void setCreateAt(Date createAt) {
    this.createAt = createAt;
  }

  public Date getUpdateAt() {
    return updateAt;
  }

  public void setUpdateAt(Date updateAt) {
    this.updateAt = updateAt;
  }

  public Boolean getEnabled() {
    return enabled;
  }

  public void setEnabled(Boolean enabled) {
    this.enabled = enabled;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof User)) {
      return false;
    }
    User user = (User) o;
    return Objects.equal(id, user.id)
        && Objects.equal(username, user.username)
        && Objects.equal(password, user.password)
        && Objects.equal(role, user.role)
        && Objects.equal(createAt, user.createAt)
        && Objects.equal(updateAt, user.updateAt)
        && Objects.equal(enabled, user.enabled);
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(id, username, password, role, createAt, updateAt, enabled);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("id", id)
        .add("username", username)
        .add("password", password)
        .add("role", role)
        .toString();
  }
}
