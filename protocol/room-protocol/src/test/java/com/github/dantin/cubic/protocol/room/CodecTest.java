package com.github.dantin.cubic.protocol.room;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.UUID;
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

  @Test
  public void marshalPagination_thenSuccess() {
    final int pages = 10;
    final int page = 1;
    final int size = 1;

    RoutePage.Builder builder = RoutePage.builder();
    builder.pages(pages).page(page).size(size);
    for (int i = 0; i < size; i++) {
      int id = page * size + i;
      Route.Builder route = Route.builder().id(String.valueOf(id)).name("route " + id);
      route.addStream(
          Stream.builder()
              .role(Role.ADMIN.getAlias())
              .type(Device.CAMERA.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.ADMIN.getAlias())
              .type(Device.DEVICE.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.USER.getAlias())
              .type(Device.CAMERA.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      route.addStream(
          Stream.builder()
              .role(Role.USER.getAlias())
              .type(Device.DEVICE.getAlias())
              .uri("srt::" + UUID.randomUUID().toString())
              .build());
      builder.addRoute(route.build());
    }

    RoutePage orig = builder.build();
    RoutePage actual = Utility.marshal(orig, RoutePage.class);

    assertNotNull(actual);
    assertEquals(page, actual.getPage());
    assertEquals(pages, actual.getPages());
    assertEquals(size, actual.getRoutes().size());
    assertEquals(orig.getRoutes().size(), actual.getRoutes().size());
    assertThat(actual.getRoutes().get(0), is(instanceOf(Route.class)));
    assertThat(actual.getRoutes().get(0).getStreams().get(0), is(instanceOf(Stream.class)));
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
