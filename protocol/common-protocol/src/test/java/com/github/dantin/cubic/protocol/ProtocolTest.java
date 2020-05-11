package com.github.dantin.cubic.protocol;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;

public final class ProtocolTest {
  private static final ObjectMapper MAPPER = new ObjectMapper();

  @Test
  public void serializeAndDeserialize() {
    Pagination.Builder<String> builder = Pagination.builder();
    builder.page(1).pages(10).total(99).hasPrevious(false).hasNext(true);
    builder.addItem("item1");
    Pagination<String> page = builder.build();

    assertThat(page.getPage(), is(1));
    assertThat(page.getPages(), is(10));

    Pagination<String> actual = null;

    try {
      // serialize
      String json = MAPPER.writeValueAsString(page);
      // deserialize
      actual = MAPPER.readValue(json, new TypeReference<Pagination<String>>() {});
    } catch (JsonProcessingException e) {
      assertNull("serialize/deserialize error", e);
    }

    assertNotNull(actual);
    assertThat(actual.getPages(), is(10));
  }
}
