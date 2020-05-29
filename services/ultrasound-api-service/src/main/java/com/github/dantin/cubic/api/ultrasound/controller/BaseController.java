package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.base.exception.BusinessException;
import com.google.common.base.Strings;
import java.util.Objects;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.keycloak.KeycloakSecurityContext;
import org.keycloak.representations.AccessToken.Access;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

public class BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(BaseController.class);

  private final HttpServletRequest request;

  @Value("${keycloak.resource}")
  private String clientId;

  public BaseController(HttpServletRequest request) {
    this.request = request;
  }

  protected KeycloakSecurityContext getKeycloakSecurityContext() {
    KeycloakSecurityContext context =
        (KeycloakSecurityContext) request.getAttribute(KeycloakSecurityContext.class.getName());
    if (Objects.isNull(context) || Objects.isNull(context.getToken())) {
      LOGGER.warn("no security context or token found");
      throw new BusinessException("username not set");
    }
    return context;
  }

  protected String getUsername() {
    KeycloakSecurityContext context = getKeycloakSecurityContext();
    String username = context.getToken().getPreferredUsername();
    if (Strings.isNullOrEmpty(username)) {
      LOGGER.warn("username not found in token");
      throw new BusinessException("username null or empty");
    }
    return username;
  }

  protected Set<String> getResourceAccess() {
    KeycloakSecurityContext context = getKeycloakSecurityContext();
    Access access = context.getToken().getResourceAccess(clientId);
    if (Objects.isNull(access)) {
      LOGGER.warn("resource_access not found in token");
      throw new BusinessException("username null or empty");
    }
    return access.getRoles();
  }
}
