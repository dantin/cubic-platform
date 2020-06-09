package com.github.dantin.cubic.smh.model.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.github.dantin.cubic.base.Builder;

abstract class SecurityResponse {

  private final String states;

  SecurityResponse(SecurityResponseBuilder<? extends SecurityResponseBuilder<?, ?>, ?> builder) {
    this.states = builder.states;
  }

  @JsonGetter("states")
  public String getStates() {
    return states;
  }

  abstract static class SecurityResponseBuilder<T extends SecurityResponseBuilder<T, B>, B>
      implements Builder<B> {
    private final T myInstance;

    private String states;

    @SuppressWarnings("unchecked")
    SecurityResponseBuilder() {
      this.myInstance = (T) this;
    }

    @JsonSetter("states")
    public T states(String states) {
      this.states = states;
      return myInstance;
    }
  }
}
