package com.github.dantin.cubic.protocol;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import org.junit.Test;

public final class CodecTest {
  private static final ObjectMapper MAPPER = new ObjectMapper();

  @Test
  public void marshalBasicPagination_thenSuccess() {
    DummyPage.Builder builder = DummyPage.builder();
    builder.page(1).pages(10).total(99).hasPrevious(false).hasNext(true);
    builder.addItem("item1");
    DummyPage page = builder.build();

    assertThat(page.getPage(), is(1));
    assertThat(page.getPages(), is(10));

    DummyPage actual = null;

    try {
      // serialize
      String json = MAPPER.writeValueAsString(page);
      // deserialize
      actual = MAPPER.readValue(json, DummyPage.class);
    } catch (JsonProcessingException e) {
      assertNull("serialize/deserialize error", e);
    }

    assertNotNull(actual);
    assertThat(actual.getPages(), is(10));
    assertThat(actual.getPage(), is(1));
    assertThat(actual.getSize(), is(1));
    assertFalse(actual.isHasPrevious());
    assertTrue(actual.isHasNext());
    assertThat(actual.getItems().get(0), is("item1"));
  }

  @JsonDeserialize(builder = DummyPage.Builder.class)
  public static class DummyPage extends Pagination {
    private final List<String> items;

    private DummyPage(Builder builder) {
      super(builder);
      this.items = builder.items;
    }

    public static Builder builder() {
      return new Builder();
    }

    @JsonGetter("items")
    public List<String> getItems() {
      return items;
    }

    @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
    public static final class Builder extends PaginationBuilder<Builder, DummyPage> {
      private List<String> items;

      private Builder() {
        this.items = new ArrayList<>();
      }

      @JsonSetter("items")
      public Builder items(List<String> items) {
        this.items = items;
        return this;
      }

      public Builder addItem(String item) {
        if (!Objects.isNull(item)) {
          this.items.add(item);
        }
        return this;
      }

      @Override
      public DummyPage build() {
        this.size(items.size());
        return new DummyPage(this);
      }
    }
  }
}
