package com.github.dantin.cubic.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;

/** Pagination information. */
public abstract class Pagination {

  private static final String PAGES_FIELD = "pages";
  private static final String PAGE_FIELD = "page";
  private static final String TOTAL_FIELD = "total";
  private static final String SIZE_FIELD = "size";
  private static final String HAS_PREVIOUS_FIELD = "has_previous";
  private static final String HAS_NEXT_FIELD = "has_next";

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

  @JsonGetter(PAGES_FIELD)
  public int getPages() {
    return pages;
  }

  @JsonGetter(PAGE_FIELD)
  public int getPage() {
    return page;
  }

  @JsonGetter(TOTAL_FIELD)
  public long getTotal() {
    return total;
  }

  @JsonGetter(SIZE_FIELD)
  public int getSize() {
    return size;
  }

  @JsonGetter(HAS_PREVIOUS_FIELD)
  public boolean isHasPrevious() {
    return hasPrevious;
  }

  @JsonGetter(HAS_NEXT_FIELD)
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

    @JsonSetter(PAGES_FIELD)
    public T pages(int pages) {
      this.pages = pages;
      return mInstance;
    }

    @JsonSetter(PAGE_FIELD)
    public T page(int page) {
      this.page = page;
      return mInstance;
    }

    @JsonSetter(SIZE_FIELD)
    public T size(int size) {
      this.size = size;
      return mInstance;
    }

    @JsonSetter(TOTAL_FIELD)
    public T total(long total) {
      this.total = total;
      return mInstance;
    }

    @JsonSetter(HAS_PREVIOUS_FIELD)
    public T hasPrevious(boolean hasPrevious) {
      this.hasPrevious = hasPrevious;
      return mInstance;
    }

    @JsonSetter(HAS_NEXT_FIELD)
    public T hasNext(boolean hasNext) {
      this.hasNext = hasNext;
      return mInstance;
    }
  }
}
