package com.github.dantin.cubic.api.ultrasound.interceptor;

import com.github.dantin.cubic.base.ResultCode;
import com.github.dantin.cubic.base.exception.BusinessException;
import com.github.dantin.cubic.protocol.RestResult;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
  private static final Logger LOGGER = LoggerFactory.getLogger(GlobalExceptionHandler.class);

  @ExceptionHandler({BusinessException.class})
  public ResponseEntity<RestResult> onException(HttpServletResponse response, Throwable e) {
    LOGGER.warn("business exception with http code {}", response.getStatus());
    if (e instanceof BusinessException) {
      BusinessException businessException = (BusinessException) e;
      ResultCode resultCode = businessException.getCode();
      return ResponseEntity.ok(RestResult.failure(resultCode).build());
    }
    return ResponseEntity.ok(RestResult.failure(ResultCode.UNKNOWN_SERVICE_ERROR).build());
  }
}
