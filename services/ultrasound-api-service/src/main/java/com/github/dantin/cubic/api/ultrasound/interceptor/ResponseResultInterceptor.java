package com.github.dantin.cubic.api.ultrasound.interceptor;

import com.github.dantin.cubic.protocol.ResponseResult;
import java.lang.reflect.Method;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class ResponseResultInterceptor implements HandlerInterceptor {

  private static final Logger LOGGER = LoggerFactory.getLogger(ResponseResultInterceptor.class);
  public static final String RESPONSE_RESULT_ANN = "RESPONSE-RESULT-ANN";

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws Exception {
    if (handler instanceof HandlerMethod) {
      final HandlerMethod handlerMethod = (HandlerMethod) handler;
      final Class<?> clazz = handlerMethod.getBeanType();
      final Method method = handlerMethod.getMethod();
      if (clazz.isAnnotationPresent(ResponseResult.class)) {
        request.setAttribute(RESPONSE_RESULT_ANN, clazz.getAnnotation(ResponseResult.class));
      } else if (method.isAnnotationPresent(ResponseResult.class)) {
        request.setAttribute(RESPONSE_RESULT_ANN, method.getAnnotation(ResponseResult.class));
      }
    }
    return true;
  }
}
