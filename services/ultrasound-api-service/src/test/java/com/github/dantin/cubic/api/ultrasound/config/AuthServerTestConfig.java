package com.github.dantin.cubic.api.ultrasound.config;

import java.security.KeyPair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.store.JwtAccessTokenConverter;
import org.springframework.security.oauth2.provider.token.store.KeyStoreKeyFactory;
import org.springframework.test.context.ActiveProfiles;

@Configuration
@EnableAuthorizationServer
@ActiveProfiles("test")
public class AuthServerTestConfig extends AuthorizationServerConfigurerAdapter {

  private final AuthenticationManager authenticationManager;

  @Autowired
  public AuthServerTestConfig(AuthenticationManager authenticationManager) {
    this.authenticationManager = authenticationManager;
  }

  @Override
  public void configure(AuthorizationServerSecurityConfigurer security) throws Exception {
    security.checkTokenAccess("permitAll()").allowFormAuthenticationForClients();
  }

  @Override
  public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
    clients
        .inMemory()
        .withClient("dummy_client")
        .secret("{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq")
        .authorizedGrantTypes("password", "refresh_token", "client_credentials")
        .scopes("read", "write");
  }

  @Override
  public void configure(AuthorizationServerEndpointsConfigurer endpoints) throws Exception {
    KeyStoreKeyFactory keyStoreKeyFactory =
        new KeyStoreKeyFactory(new ClassPathResource("/keystore.jks"), "password".toCharArray());
    KeyPair keyPair = keyStoreKeyFactory.getKeyPair("ultrasound", "password".toCharArray());

    JwtAccessTokenConverter accessTokenConverter = new JwtAccessTokenConverter();
    accessTokenConverter.setKeyPair(keyPair);

    endpoints
        .authenticationManager(this.authenticationManager)
        .accessTokenConverter(accessTokenConverter);
  }
}
