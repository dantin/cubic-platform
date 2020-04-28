package com.github.dantin.cubic.api.ultrasound.config;

import org.springframework.boot.autoconfigure.security.oauth2.resource.OAuth2ResourceServerProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

  @Override
  protected void configure(HttpSecurity http) throws Exception {
    http.cors()
        .and()
        .authorizeRequests()
        .anyRequest()
        .authenticated()
        .and()
        .oauth2ResourceServer()
        .jwt();
  }

  @Bean
  public JwtDecoder jwtDecoder(OAuth2ResourceServerProperties properties) {
    NimbusJwtDecoder jwtDecoder =
        NimbusJwtDecoder.withJwkSetUri(properties.getJwt().getJwkSetUri()).build();
    jwtDecoder.setClaimSetConverter(new OrganizationSubClaimAdapter());
    return jwtDecoder;
  }
}
