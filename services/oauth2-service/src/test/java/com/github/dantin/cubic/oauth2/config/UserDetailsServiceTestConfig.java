package com.github.dantin.cubic.oauth2.config;

import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;
import org.springframework.security.core.userdetails.UserDetailsService;

@Profile("test")
@Configuration
public class UserDetailsServiceTestConfig {

  @Bean
  @Primary
  @Qualifier("userDetailsServiceImpl")
  public UserDetailsService userDetailsService() {
    return Mockito.mock(UserDetailsService.class);
  }
}
