package com.github.dantin.cubic.ultrasound.config;

import java.io.IOException;
import java.nio.file.Files;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.DefaultTokenServices;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.oauth2.provider.token.store.JwtAccessTokenConverter;
import org.springframework.security.oauth2.provider.token.store.JwtTokenStore;

@Configuration
@EnableResourceServer
@EnableConfigurationProperties(SecurityProperties.class)
public class ResourceServerConfig extends ResourceServerConfigurerAdapter {

  private static final String ROOT_PATTERN = "/**";

  private final SecurityProperties securityProperties;

  public ResourceServerConfig(SecurityProperties securityProperties) {
    this.securityProperties = securityProperties;
  }

  @Override
  public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
    resources.tokenStore(tokenStore());
  }

  @Override
  public void configure(HttpSecurity http) throws Exception {
    http.authorizeRequests()
        .antMatchers(HttpMethod.GET, ROOT_PATTERN)
        .access("#oauth2.hasScope('read')")
        .antMatchers(HttpMethod.POST, ROOT_PATTERN)
        .access("#oauth2.hasScope('write')")
        .antMatchers(HttpMethod.PATCH, ROOT_PATTERN)
        .access("#oauth2.hasScope('write')")
        .antMatchers(HttpMethod.PUT, ROOT_PATTERN)
        .access("#oauth2.hasScope('write')")
        .antMatchers(HttpMethod.DELETE, ROOT_PATTERN)
        .access("#oauth2.hasScope('write')");
  }

  @Bean
  public DefaultTokenServices tokenServices(TokenStore tokenStore) {
    DefaultTokenServices tokenServices = new DefaultTokenServices();
    tokenServices.setTokenStore(tokenStore);
    return tokenServices;
  }

  @Bean
  public TokenStore tokenStore() {
    return new JwtTokenStore(accessTokenConverter());
  }

  @Bean
  public JwtAccessTokenConverter accessTokenConverter() {
    try {
      JwtAccessTokenConverter accessTokenConverter = new JwtAccessTokenConverter();
      String key =
          new String(
              Files.readAllBytes(securityProperties.getJwt().getPublicKey().getFile().toPath()));
      accessTokenConverter.setVerifierKey(key);
      return accessTokenConverter;
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }
}
