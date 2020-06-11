package com.github.dantin.cubic.api.ultrasound.interceptor;

import com.github.dantin.cubic.protocol.ResponseResult;
import com.github.dantin.cubic.protocol.RestResult;
import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

@SuppressWarnings("NullableProblems")
@ControllerAdvice
public class ResponseResultHandler implements ResponseBodyAdvice<Object> {

  private static final Logger LOGGER = LoggerFactory.getLogger(ResponseResultHandler.class);

  @Override
  public boolean supports(
      MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
    ServletRequestAttributes sra =
        ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes());
    if (Objects.isNull(sra)) {
      return false;
    }
    HttpServletRequest request = sra.getRequest();
    ResponseResult responseResultAnn =
        (ResponseResult) request.getAttribute(ResponseResultInterceptor.RESPONSE_RESULT_ANN);
    return responseResultAnn != null;
  }

  @Override
  public Object beforeBodyWrite(
      Object body,
      MethodParameter returnType,
      MediaType selectedContentType,
      Class<? extends HttpMessageConverter<?>> selectedConverterType,
      ServerHttpRequest request,
      ServerHttpResponse response) {
    LOGGER.info("rewrite response");
    return RestResult.success(body).build();
  }
}
