package com.github.dantin.cubic.protocol.chat;

import com.google.common.base.MoreObjects;

public class ChatMessage {

  private MessageType type;
  private String content;
  private String sender;

  public enum MessageType {
    MESSAGE,
    JOIN,
    LEAVE
  }

  public MessageType getType() {
    return type;
  }

  public void setType(MessageType type) {
    this.type = type;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getSender() {
    return sender;
  }

  public void setSender(String sender) {
    this.sender = sender;
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("type", type)
        .add("sender", sender)
        .add("content", content)
        .toString();
  }
}
