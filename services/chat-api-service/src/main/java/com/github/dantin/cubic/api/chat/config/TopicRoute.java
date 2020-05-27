package com.github.dantin.cubic.api.chat.config;

public enum TopicRoute {
  USER_STATUS("user.status"),
  BROADCAST("broadcast");

  private final String alias;

  TopicRoute(String alias) {
    this.alias = alias;
  }

  public String getAlias() {
    return alias;
  }
}
