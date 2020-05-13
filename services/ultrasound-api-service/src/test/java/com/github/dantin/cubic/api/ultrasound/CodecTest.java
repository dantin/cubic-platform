package com.github.dantin.cubic.api.ultrasound;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.protocol.room.Device;
import com.github.dantin.cubic.protocol.room.Role;
import com.github.dantin.cubic.protocol.room.Route;
import com.github.dantin.cubic.protocol.room.RoutePage;
import com.github.dantin.cubic.protocol.room.Stream;
import java.util.UUID;
import org.junit.Test;

public class CodecTest {
  private static final ObjectMapper MAPPER = new ObjectMapper();

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

    RoutePage actual = null;
    try {
      // serialize
      String json = MAPPER.writeValueAsString(builder.build());
      // deserialize
      actual = MAPPER.readValue(json, RoutePage.class);
    } catch (JsonProcessingException e) {
      assertNull("serialize/deserialize error", e);
    }

    assertNotNull(actual);
  }
}
