package com.github.dantin.cubic.shm.model.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import java.util.ArrayList;
import java.util.List;

@JsonDeserialize(builder = ListRouteResponse.Builder.class)
public final class ListRouteResponse extends SecurityResponse {

  private final Integer total;

  private final List<Source> sources;

  ListRouteResponse(Builder builder) {
    super(builder);
    this.total = builder.total;
    this.sources = builder.sources;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter("total")
  public Integer getTotal() {
    return total;
  }

  @JsonGetter("sources")
  public List<Source> getSources() {
    return sources;
  }

  @JsonDeserialize(builder = Source.Builder.class)
  public static class Source {

    private final String name;

    Source(Builder builder) {
      this.name = builder.name;
    }

    public static Builder builder() {
      return new Builder();
    }

    @JsonGetter("taskname")
    public String getName() {
      return name;
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
    public static final class Builder implements com.github.dantin.cubic.base.Builder<Source> {
      private String name;

      Builder() {}

      @JsonSetter("taskname")
      public Builder name(String name) {
        this.name = name;
        return this;
      }

      @Override
      public Source build() {
        return new Source(this);
      }
    }
  }

  @JsonPOJOBuilder(buildMethodName = "build", withPrefix = "")
  public static final class Builder extends SecurityResponseBuilder<Builder, ListRouteResponse> {
    private Integer total;
    private List<Source> sources;

    private Builder() {
      this.sources = new ArrayList<>();
    }

    public Builder total(Integer total) {
      this.total = total;
      return this;
    }

    public Builder addSource(Source source) {
      sources.add(source);
      return this;
    }

    @JsonSetter("sources")
    public Builder sources(List<Source> sources) {
      this.sources = sources;
      return this;
    }

    @Override
    public ListRouteResponse build() {
      return new ListRouteResponse(this);
    }
  }
}
