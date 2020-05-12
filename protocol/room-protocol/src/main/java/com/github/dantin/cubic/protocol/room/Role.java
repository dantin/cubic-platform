package com.github.dantin.cubic.protocol.room;

/** Role is an enum class that contains all supported privilege. */
public enum Role {
  UNKNOWN(0, "UNKNOWN"),
  ROOT(1, "ROOT"),
  ADMIN(2, "ADMIN"),
  USER(3, "USER");

  private final int code;
  private final String alias;

  Role(int code, String alias) {
    this.code = code;
    this.alias = alias;
  }

  public static Role from(int value) {
    for (Role e : values()) {
      if (e.code == value) {
        return e;
      }
    }
    return UNKNOWN;
  }

  public static Role from(String value) {
    for (Role e : values()) {
      if (e.alias.equalsIgnoreCase(value)) {
        return e;
      }
    }
    return UNKNOWN;
  }

  public String getAlias() {
    return alias;
  }
}
