package com.github.dantin.cubic.api.ultrasound.config;

import com.github.dantin.cubic.api.ultrasound.interceptor.ResponseResultInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {

  private final ResponseResultInterceptor responseResultInterceptor;

  public WebMvcConfig(ResponseResultInterceptor responseResultInterceptor) {
    this.responseResultInterceptor = responseResultInterceptor;
  }

  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(responseResultInterceptor);
  }
}