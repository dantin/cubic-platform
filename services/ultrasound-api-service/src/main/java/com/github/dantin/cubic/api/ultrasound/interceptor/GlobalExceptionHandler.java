package com.github.dantin.cubic.api.ultrasound.interceptor;

import com.github.dantin.cubic.base.ResultCode;
import com.github.dantin.cubic.base.exception.BusinessException;
import com.github.dantin.cubic.protocol.RestResult;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {
  private static final Logger LOGGER = LoggerFactory.getLogger(GlobalExceptionHandler.class);

  @ExceptionHandler
  public RestResult onException(HttpServletResponse response, Throwable e) {
    LOGGER.warn("business exception with http code {}", response.getStatus());
    if (e instanceof BusinessException) {
      BusinessException businessException = (BusinessException) e;
      ResultCode resultCode = businessException.getCode();
      return RestResult.failure(resultCode).build();
    }
    return RestResult.failure(ResultCode.UNKNOWN_SERVICE_ERROR).build();
  }
}
