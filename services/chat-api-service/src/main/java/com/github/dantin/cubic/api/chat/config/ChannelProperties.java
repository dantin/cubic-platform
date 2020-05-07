package com.github.dantin.cubic.api.chat.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "channel")
public class ChannelProperties {
  private String broadcast;
  private String userStatus;

  public String getBroadcast() {
    return broadcast;
  }

  public void setBroadcast(String broadcast) {
    this.broadcast = broadcast;
  }

  public String getUserStatus() {
    return userStatus;
  }

  public void setUserStatus(String userStatus) {
    this.userStatus = userStatus;
  }
}
