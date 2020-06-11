package com.github.dantin.cubic.base;

/**
 * {@code ReturnCode} is the return code of resource server.
 *
 * <pre>
 *   +-------------+----------------------+
 *   | 1001 ~ 1999 | Invalid Parameter    |
 *   | 2001 ~ 2999 | Authentication Error |
 *   | 3001 ~ 3999 | Business Error       |
 *   | 4001 ~ 4999 | Service Error        |
 *   +-------------|----------------------+
 * </pre>
 */
public enum ResultCode {
  SUCCESS(0, "success"),
  FAILURE(1, "failure"),
  PARAM_IS_INVALID(1001, "parameter is invalid"),
  PARAM_IS_BLANK(1002, "parameter is blank"),
  PARAM_TYPE_ERROR(1003, "parameter type error"),
  PARAM_MISSING_ERROR(1004, "missing parameter"),
  USER_NOT_LOGIN(2001, "user not login"),
  USER_ACCOUNT_ERROR(2002, "bad password or account not found"),
  USER_REFRESH_TOKEN_ERROR(2003, "refresh token error"),
  USER_FORBIDDEN(2004, "account is forbidden"),
  USER_NOT_EXISTS(2005, "user not exists"),
  USER_IN_USE(2006, "user already login"),
  USER_LOGOUT_ERROR(2007, "user logout error"),
  ITEM_NOT_FOUND(3001, "item not found"),
  SERVICE_ERROR(4001, "service internal error"),
  UNKNOWN_SERVICE_ERROR(4999, "unknown service error");

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
