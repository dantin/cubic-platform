package com.github.dantin.cubic.base.exception;

import com.github.dantin.cubic.base.ResultCode;

public class BusinessException extends RuntimeException {

  private ResultCode code = ResultCode.FAILURE;

  /** Default constructor. */
  public BusinessException() {
    super();
  }

  /**
   * Constructor with parameters.
   *
   * @param message message
   */
  public BusinessException(String message) {
    super(message);
  }

  public BusinessException(String message, ResultCode code) {
    super(message);
    this.code = code;
  }

  /**
   * Constructor with parameters.
   *
   * @param message message
   * @param cause cause
   */
  public BusinessException(String message, Throwable cause) {
    super(message, cause);
  }

  /**
   * Constructor with message format.
   *
   * @param format message format
   * @param args arguments list
   */
  public BusinessException(String format, Object... args) {
    super(String.format(format, args));
  }

  /**
   * Constructor with cause.
   *
   * @param cause exception cause
   */
  public BusinessException(Throwable cause) {
    super(cause);
  }

  public ResultCode getCode() {
    return code;
  }
}
