package com.github.dantin.cubic.protocol.room;

/** Device is an enum class that contains all supported device type. */
public enum Device {
  UNKNOWN(0, "UNKNOWN"),
  CAMERA(1, "CAMERA"),
  DEVICE(2, "DEVICE");

  private final int code;
  private final String alias;

  Device(int code, String alias) {
    this.code = code;
    this.alias = alias;
  }

  public static Device from(int value) {
    for (Device e : values()) {
      if (e.code == value) {
        return e;
      }
    }
    return UNKNOWN;
  }

  public static Device from(String value) {
    for (Device e : values()) {
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
