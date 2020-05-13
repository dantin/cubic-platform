package com.github.dantin.cubic.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;

/** Pagination information. */
public abstract class Pagination {

  private final int pages;
  private final int page;
  private final long total;
  private final int size;
  private final boolean hasPrevious;
  private final boolean hasNext;

  protected Pagination(PaginationBuilder<? extends PaginationBuilder<?, ?>, ?> builder) {
    this.pages = builder.pages;
    this.page = builder.page;
    this.total = builder.total;
    this.size = builder.size;
    this.hasPrevious = builder.hasPrevious;
    this.hasNext = builder.hasNext;
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

  public abstract static class PaginationBuilder<T extends PaginationBuilder<T, B>, B>
      implements com.github.dantin.cubic.base.Builder<B> {

    private final T mInstance;

    private int pages;
    private int page;
    private int size;
    private long total;
    private boolean hasPrevious;
    private boolean hasNext;

    @SuppressWarnings("unchecked")
    protected PaginationBuilder() {
      this.mInstance = (T) this;
    }

    public T copyOf(Pagination src) {
      this.pages = src.pages;
      this.page = src.page;
      this.size = src.size;
      this.total = src.total;
      this.hasPrevious = src.hasPrevious;
      this.hasNext = src.hasNext;

      return mInstance;
    }

    @JsonSetter("pages")
    public T pages(int pages) {
      this.pages = pages;
      return mInstance;
    }

    @JsonSetter("page")
    public T page(int page) {
      this.page = page;
      return mInstance;
    }

    @JsonSetter("size")
    public T size(int size) {
      this.size = size;
      return mInstance;
    }

    @JsonSetter("total")
    public T total(long total) {
      this.total = total;
      return mInstance;
    }

    @JsonSetter("has_previous")
    public T hasPrevious(boolean hasPrevious) {
      this.hasPrevious = hasPrevious;
      return mInstance;
    }

    @JsonSetter("has_next")
    public T hasNext(boolean hasNext) {
      this.hasNext = hasNext;
      return mInstance;
    }
  }
}
