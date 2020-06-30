package com.github.dantin.cubic.protocol.room;

/** Scope is an enum class that the stream is used to. */
public enum Scope {
  UNKNOWN(0, "UNKNOWN"),
  ROOT(1, "ROOT"),
  ADMIN(2, "ADMIN"),
  USER(3, "USER"),
  TEMP(4, "TEMP");

  private final int code;
  private final String alias;

  Scope(int code, String alias) {
    this.code = code;
    this.alias = alias;
  }

  public static Scope from(int value) {
    for (Scope e : values()) {
      if (e.code == value) {
        return e;
      }
    }
    return UNKNOWN;
  }

  public static Scope from(String value) {
    for (Scope e : values()) {
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
