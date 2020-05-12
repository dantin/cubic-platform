package com.github.dantin.cubic.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Pagination information.
 *
 * @param <T> item type in pagination contents
 */
@JsonDeserialize(builder = Pagination.Builder.class)
public class Pagination<T> {

  private final int pages;
  private final int page;
  private final long total;
  private final int size;
  private final boolean hasPrevious;
  private final boolean hasNext;
  private final List<T> items;

  private Pagination(Builder<T> builder) {
    this.pages = builder.pages;
    this.page = builder.page;
    this.total = builder.total;
    this.size = builder.size;
    this.hasPrevious = builder.hasPrevious;
    this.hasNext = builder.hasNext;
    this.items = builder.items;
  }

  public static <T> Builder<T> builder() {
    return new Builder<>();
  }

  public static <T> Builder<T> copyOf(Pagination<T> o) {
    Builder<T> builder = new Builder<>();
    builder.size = o.size;
    builder.pages = o.pages;
    builder.page = o.page;
    builder.total = o.total;
    builder.hasPrevious = o.hasPrevious;
    builder.hasNext = o.hasNext;
    return builder;
  }

  @JsonGetter("pages")
  public int getPages() {
    return pages;
  }

  @JsonGetter("page")
  public int getPage() {
    return page;
  }

  @JsonGetter("total")
  public long getTotal() {
    return total;
  }

  @JsonGetter("size")
  public int getSize() {
    return size;
  }

  @JsonGetter("has_previous")
  public boolean isHasPrevious() {
    return hasPrevious;
  }

  @JsonGetter("has_next")
  public boolean isHasNext() {
    return hasNext;
  }

  @JsonGetter("items")
  public List<T> getItems() {
    return items;
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder<T>
      implements com.github.dantin.cubic.base.Builder<Pagination<T>> {
    private int pages;
    private int page;
    private int size;
    private long total;
    private boolean hasPrevious;
    private boolean hasNext;
    private List<T> items;

    Builder() {
      this.items = new ArrayList<>();
    }

    @JsonSetter("pages")
    public Builder<T> pages(int pages) {
      this.pages = pages;
      return this;
    }

    @JsonSetter("page")
    public Builder<T> page(int page) {
      this.page = page;
      return this;
    }

    @JsonSetter("size")
    public Builder<T> size(int size) {
      this.size = size;
      return this;
    }

    @JsonSetter("total")
    public Builder<T> total(long total) {
      this.total = total;
      return this;
    }

    @JsonSetter("has_previous")
    public Builder<T> hasPrevious(boolean hasPrevious) {
      this.hasPrevious = hasPrevious;
      return this;
    }

    @JsonSetter("has_next")
    public Builder<T> hasNext(boolean hasNext) {
      this.hasNext = hasNext;
      return this;
    }

    @JsonSetter("items")
    public Builder<T> items(List<T> items) {
      this.items = items;
      return this;
    }

    public Builder<T> addItem(T item) {
      if (Objects.nonNull(item)) {
        this.items.add(item);
      }
      return this;
    }

    @Override
    public Pagination<T> build() {
      if (!Objects.isNull(items)) {
        this.size = items.size();
      }
      return new Pagination<>(this);
    }
  }
}
