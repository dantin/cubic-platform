package com.github.dantin.cubic.api.chat.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "customized.redis-key")
public class CustomizedKeyProperties {
  private String onlineUser;

  public String getOnlineUser() {
    return onlineUser;
  }

  public void setOnlineUser(String onlineUser) {
    this.onlineUser = onlineUser;
  }
}
