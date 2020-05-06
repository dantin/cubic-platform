package com.github.dantin.cubic.base.exception;

public class BusinessException extends RuntimeException {

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
}
