package com.github.dantin.cubic.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Pagination information.
 *
 * @param <T> item type in pagination contents
 */
public class Pagination<T> {

  private final int pages;
  private final int page;
  private final long total;
  private final int size;
  private final boolean hasPrevious;
  private final boolean hasNext;
  private final List<T> items;

  Pagination(Builder<T> builder) {
    this.pages = builder.pages;
    this.page = builder.page;
    this.total = builder.total;
    this.size = builder.items.size();
    this.hasPrevious = builder.hasPrevious;
    this.hasNext = builder.hasNext;
    this.items = builder.items;
  }

  public static <T> Builder<T> builder() {
    return new Builder<>();
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

  public static final class Builder<T>
      implements com.github.dantin.cubic.base.Builder<Pagination<T>> {
    private int pages;
    private int page;
    private long total;
    private boolean hasPrevious;
    private boolean hasNext;
    private List<T> items;

    Builder() {
      this.items = new ArrayList<>();
    }

    public Builder<T> pages(int pages) {
      if (pages > 0) {
        this.pages = pages;
      }
      return this;
    }

    public Builder<T> page(int page) {
      if (page > 0) {
        this.page = page;
      }
      return this;
    }

    public Builder<T> total(long total) {
      if (total > 0) {
        this.total = total;
      }
      return this;
    }

    public Builder<T> hasPrevious(boolean hasPrevious) {
      this.hasPrevious = hasPrevious;
      return this;
    }

    public Builder<T> hasNext(boolean hasNext) {
      this.hasNext = hasNext;
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
      return new Pagination<>(this);
    }
  }
}
