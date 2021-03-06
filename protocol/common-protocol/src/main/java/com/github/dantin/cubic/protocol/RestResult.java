package com.github.dantin.cubic.protocol;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.github.dantin.cubic.base.ResultCode;

/** RestResult is the RESTFUL response body entity. */
@JsonInclude(Include.NON_NULL)
public class RestResult {

  private static final String CODE_FIELD = "code";
  private static final String MESSAGE_FIELD = "message";
  private static final String DATA_FIELD = "data";

  private final Integer code;
  private final String message;
  private final Object data;

  private RestResult(Builder builder) {
    this.code = builder.code;
    this.message = builder.message;
    this.data = builder.data;
  }

  public static Builder success() {
    return new Builder().resultCode(ResultCode.SUCCESS);
  }

  public static Builder success(Object data) {
    return new Builder().resultCode(ResultCode.SUCCESS).data(data);
  }

  public static Builder failure() {
    return new Builder().resultCode(ResultCode.UNKNOWN_SERVICE_ERROR);
  }

  public static Builder failure(ResultCode resultCode) {
    return new Builder().resultCode(resultCode);
  }

  @JsonGetter(CODE_FIELD)
  public Integer getCode() {
    return code;
  }

  @JsonGetter(MESSAGE_FIELD)
  public String getMessage() {
    return message;
  }

  @JsonGetter(DATA_FIELD)
  public Object getData() {
    return data;
  }

  public static class Builder implements com.github.dantin.cubic.base.Builder<RestResult> {
    private Integer code;
    private String message;
    private Object data;

    Builder() {}

    public Builder resultCode(ResultCode resultCode) {
      this.code = resultCode.getCode();
      this.message = resultCode.getMessage();
      return this;
    }

    public Builder data(Object data) {
      this.data = data;
      return this;
    }

    @Override
    public RestResult build() {
      return new RestResult(this);
    }
  }
}
