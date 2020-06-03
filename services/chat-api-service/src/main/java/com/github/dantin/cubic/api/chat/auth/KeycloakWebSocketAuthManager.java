package com.github.dantin.cubic.api.chat.auth;

import java.util.List;
import java.util.stream.Collectors;
import org.keycloak.adapters.KeycloakDeployment;
import org.keycloak.adapters.rotation.AdapterTokenVerifier;
import org.keycloak.adapters.springboot.KeycloakSpringBootConfigResolver;
import org.keycloak.common.VerificationException;
import org.keycloak.representations.AccessToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;

@Component
@Qualifier("websocket")
public class KeycloakWebSocketAuthManager implements AuthenticationManager {

  private static final Logger LOGGER = LoggerFactory.getLogger(KeycloakWebSocketAuthManager.class);

  private final KeycloakSpringBootConfigResolver keycloakSpringBootConfigResolver;

  public KeycloakWebSocketAuthManager(
      KeycloakSpringBootConfigResolver keycloakSpringBootConfigResolver) {
    this.keycloakSpringBootConfigResolver = keycloakSpringBootConfigResolver;
  }

  @Override
  public Authentication authenticate(Authentication authentication) throws AuthenticationException {
    JWSAuthenticationToken token = (JWSAuthenticationToken) authentication;
    String tokenString = (String) token.getCredentials();
    try {
      KeycloakDeployment resolve = keycloakSpringBootConfigResolver.resolve(null);
      AccessToken accessToken = AdapterTokenVerifier.verifyToken(tokenString, resolve);
      List<GrantedAuthority> authorities =
          accessToken
              .getRealmAccess()
              .getRoles()
              .stream()
              .map(SimpleGrantedAuthority::new)
              .collect(Collectors.toList());
      User user = new User(accessToken.getPreferredUsername(), "", authorities);
      token = new JWSAuthenticationToken(tokenString, user, authorities);
      token.setAuthenticated(true);
    } catch (VerificationException e) {
      LOGGER.warn("bad websocket authentication token {}:", tokenString, e);
      throw new BadCredentialsException("Invalid token");
    }
    return token;
  }
}
