package com.github.dantin.cubic.protocol.chat;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.protocol.chat.ChatMessage.MessageType;
import org.junit.Test;

public class CodecTest {

  @Test
  public void marshalStream_thenSuccess() {
    final String content = "content";
    final String sender = "sender";
    final MessageType type = MessageType.JOIN;

    ChatMessage message = ChatMessage.builder().type(type).sender(sender).content(content).build();
    ChatMessage actual = Utility.marshal(message, ChatMessage.class);

    assertNotNull(actual);
    assertThat(actual.getContent(), is(content));
    assertThat(actual.getType(), is(type));
    assertThat(actual.getSender(), is(sender));
  }

  private static class Utility {
    private static final ObjectMapper MAPPER = new ObjectMapper();

    public static <T> T marshal(T obj, Class<T> clazz) {
      try {
        // serialize
        String json = MAPPER.writeValueAsString(obj);
        // deserialize
        return MAPPER.readValue(json, clazz);
      } catch (JsonProcessingException e) {
        assertNull("serialize/deserialize error", e);
        return null;
      }
    }
  }
}
