package com.github.dantin.cubic.protocol;

/**
 * {@code ReturnCode} is the return code of resource server.
 *
 * <pre>
 *   +-------------+-------------------+
 *   | 1001 ~ 1999 | Invalid Parameter |
 *   | 2001 ~ 2999 | User Related      |
 *   | 3001 ~ 3999 | Service Error     |
 *   +-------------|-------------------+
 * </pre>
 */
public enum ResultCode {
  SUCCESS(1, "success"),
  PARAM_IS_INVALID(1001, "parameter is invalid"),
  PARAM_IS_BLANK(1002, "parameter is blank"),
  PARAM_TYPE_ERROR(1003, "parameter type error"),
  PARAM_MISSING_ERROR(1004, "missing parameter"),
  USER_NOT_LOGIN(2001, "user not login"),
  USER_ACCOUNT_ERROR(2002, "bad password or account not found"),
  USER_FORBIDDEN(2003, "account is forbidden"),
  USER_NOT_EXISTS(2004, "user not exists"),
  USER_IN_USE(2005, "user already login"),
  SERVICE_ERROR(3001, "service internal error");

  ResultCode(Integer code, String message) {
    this.code = code;
    this.message = message;
  }

  private final Integer code;
  private final String message;

  public Integer getCode() {
    return code;
  }

  public String getMessage() {
    return message;
  }
}
