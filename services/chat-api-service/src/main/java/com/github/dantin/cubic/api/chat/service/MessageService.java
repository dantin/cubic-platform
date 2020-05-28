package com.github.dantin.cubic.api.chat.service;

public interface MessageService {

  void broadcast(String message);

  void updateStatus(String message);

  enum TopicRoute {
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
}
