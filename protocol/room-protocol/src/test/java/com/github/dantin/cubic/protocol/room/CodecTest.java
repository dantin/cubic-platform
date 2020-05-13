package com.github.dantin.cubic.protocol.room;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;

public class CodecTest {

  @Test
  public void marshalStream_thenSuccess() {
    final String uri = "srt://xxx.xx.xx.x";
    final String role = Role.ADMIN.getAlias();
    final String type = Device.CAMERA.getAlias();

    Stream stream = Stream.builder().role(role).type(type).uri(uri).build();
    Stream actual = Utility.marshal(stream, Stream.class);

    assertNotNull(actual);
    assertThat(actual.getRole(), is(role));
    assertThat(actual.getType(), is(type));
    assertThat(actual.getUri(), is(uri));
  }

  @Test
  public void marshalRoute_thenSuccess() {
    String id = "1";
    String name = "name";
    Stream stream =
        Stream.builder()
            .role(Role.ADMIN.getAlias())
            .type(Device.CAMERA.getAlias())
            .uri("xxx")
            .build();

    Route route = Route.builder().name(name).id(id).addStream(stream).build();
    Route actual = Utility.marshal(route, Route.class);

    assertNotNull(actual);
    assertThat(actual.getId(), is(id));
    assertThat(actual.getName(), is(name));
    assertEquals(1, actual.getStreams().size());
    assertThat(stream, is(actual.getStreams().get(0)));
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
