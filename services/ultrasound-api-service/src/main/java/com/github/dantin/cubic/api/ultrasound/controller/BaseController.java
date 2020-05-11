package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.base.exception.BusinessException;
import com.google.common.base.Strings;
import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import org.keycloak.KeycloakSecurityContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(BaseController.class);

  private final HttpServletRequest request;

  public BaseController(HttpServletRequest request) {
    this.request = request;
  }

  private KeycloakSecurityContext getKeycloakSecurityContext() {
    return (KeycloakSecurityContext) request.getAttribute(KeycloakSecurityContext.class.getName());
  }

  protected String getUsername() {
    KeycloakSecurityContext context = getKeycloakSecurityContext();
    if (Objects.isNull(context) || Objects.isNull(context.getToken())) {
      throw new BusinessException("username not set");
    }
    String username = context.getToken().getPreferredUsername();
    if (Strings.isNullOrEmpty(username)) {
      throw new BusinessException("username null or empty");
    }
    return username;
  }
}
