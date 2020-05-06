package com.github.dantin.cubic.api.ultrasound.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.test.context.ActiveProfiles;

@Configuration
@EnableWebSecurity
@ActiveProfiles("test")
@Order(1)
public class WebSecurityTestConfig extends WebSecurityConfigurerAdapter {

  @Bean
  @Override
  public AuthenticationManager authenticationManagerBean() throws Exception {
    // expose AuthenticationManager
    return super.authenticationManagerBean();
  }
}
