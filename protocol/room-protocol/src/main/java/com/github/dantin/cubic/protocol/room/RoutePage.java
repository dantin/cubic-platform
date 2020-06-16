package com.github.dantin.cubic.protocol.room;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.github.dantin.cubic.protocol.Pagination;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@JsonDeserialize(builder = RoutePage.Builder.class)
public class RoutePage extends Pagination {

  private static final String ROUTES_FIELD = "routes";

  private final List<Route> routes;

  private RoutePage(Builder builder) {
    super(builder);
    this.routes = builder.routes;
  }

  public static Builder builder() {
    return new Builder();
  }

  @JsonGetter(ROUTES_FIELD)
  public List<Route> getRoutes() {
    return routes;
  }

  public static final class Builder extends PaginationBuilder<Builder, RoutePage> {
    private List<Route> routes;

    private Builder() {
      this.routes = new ArrayList<>();
    }

    @JsonSetter(ROUTES_FIELD)
    public Builder routes(List<Route> routes) {
      this.routes = routes;
      return this;
    }

    public Builder addRoute(Route route) {
      if (!Objects.isNull(route)) {
        this.routes.add(route);
      }
      return this;
    }

    @Override
    public RoutePage build() {
      this.size(routes.size());
      return new RoutePage(this);
    }
  }
}
