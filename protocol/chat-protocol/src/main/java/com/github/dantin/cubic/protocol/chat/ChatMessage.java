package com.github.dantin.cubic.protocol.chat;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.google.common.base.MoreObjects;
import java.util.Objects;

@JsonDeserialize(builder = ChatMessage.Builder.class)
public class ChatMessage {

  private static final String TYPE_FIELD = "type";
  private static final String CONTENT_FIELD = "content";
  private static final String SENDER_FIELD = "sender";

  private final MessageType type;
  private final String content;
  private final String sender;

  public enum MessageType {
    MESSAGE,
    JOIN,
    LEAVE
  }

  private ChatMessage(Builder builder) {
    this.type = builder.type;
    this.content = builder.content;
    this.sender = builder.sender;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter(TYPE_FIELD)
  public MessageType getType() {
    return type;
  }

  @JsonGetter(CONTENT_FIELD)
  public String getContent() {
    return content;
  }

  @JsonGetter(SENDER_FIELD)
  public String getSender() {
    return sender;
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

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder implements com.github.dantin.cubic.base.Builder<ChatMessage> {

    private MessageType type;
    private String content;
    private String sender;

    Builder() {}

    @JsonSetter(TYPE_FIELD)
    public Builder type(MessageType type) {
      if (Objects.nonNull(type)) {
        this.type = type;
      }
      return this;
    }

    @JsonSetter(CONTENT_FIELD)
    public Builder content(String content) {
      if ((Objects.nonNull(content))) {
        this.content = content;
      }
      return this;
    }

    @JsonSetter(SENDER_FIELD)
    public Builder sender(String sender) {
      if ((Objects.nonNull(content))) {
        this.sender = sender;
      }
      return this;
    }

    @Override
    public ChatMessage build() {
      return new ChatMessage(this);
    }
  }
}
