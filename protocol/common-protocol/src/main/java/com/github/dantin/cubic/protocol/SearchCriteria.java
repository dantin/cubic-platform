package com.github.dantin.cubic.protocol;

public class SearchCriteria {
  private final int number;
  private final int size;

  private SearchCriteria(Builder builder) {
    this.number = builder.number;
    this.size = builder.size;
  }

  public static Builder builder() {
    return new Builder();
  }

  public int getNumber() {
    return number;
  }

  public int getSize() {
    return size;
  }

  public static final class Builder
      implements com.github.dantin.cubic.base.Builder<SearchCriteria> {
    private static final int DEFAULT_PAGE_NUMBER = 1;
    private static final int DEFAULT_PAGE_SIZE = 10;
    private int number;
    private int size;

    Builder() {
      this.number = DEFAULT_PAGE_NUMBER;
      this.size = DEFAULT_PAGE_SIZE;
    }

    public Builder pageNumber(int number) {
      if (number > 0) {
        this.number = number;
      }
      return this;
    }

    public Builder pageSize(int size) {
      if (size > 0) {
        this.size = size;
      }
      return this;
    }

    @Override
    public SearchCriteria build() {
      return new SearchCriteria(this);
    }
  }
}
