package com.github.dantin.cubic.user.entity;

/** Role is an enum class that contains all supported roles. */
public enum Role {
  UNKNOWN(0, "UNKNOWN", "ROLE_UNKNOWN"),
  ROOT(1, "ROOT", "ROLE_ROOT"),
  ADMIN(2, "ADMIN", "ROLE_ADMIN"),
  USER(3, "USER", "ROLE_USER");

  private final int code;
  private final String name;
  private final String role;

  Role(int code, String name, String role) {
    this.code = code;
    this.name = name;
    this.role = role;
  }

  public static Role from(int v) {
    for (Role e : values()) {
      if (e.code == v) {
        return e;
      }
    }
    return UNKNOWN;
  }

  public static Role from(String v) {
    for (Role e : values()) {
      if (e.toString().equalsIgnoreCase(v)) {
        return e;
      }
    }
    return UNKNOWN;
  }

  public int getCode() {
    return code;
  }

  @Override
  public String toString() {
    return this.role;
  }
}
