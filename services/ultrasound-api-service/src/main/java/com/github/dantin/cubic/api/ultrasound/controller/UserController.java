package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.base.CollectionsHelper;
import java.util.Map;
import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import org.keycloak.KeycloakSecurityContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

  private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

  private final HttpServletRequest request;

  @Autowired
  public UserController(HttpServletRequest request) {
    this.request = request;
  }

  @GetMapping("/profile")
  @RolesAllowed({"ultrasound-user", "ultrasound-admin", "ultrasound-root"})
  public ResponseEntity<Map<String, Object>> profile() {
    KeycloakSecurityContext context = getKeycloakSecurityContext();
    String username = context.getToken().getPreferredUsername();
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("get user profile of '{}'", username);
    }
    return ResponseEntity.ok(CollectionsHelper.mapOf("username", username));
  }

  private KeycloakSecurityContext getKeycloakSecurityContext() {
    return (KeycloakSecurityContext) request.getAttribute(KeycloakSecurityContext.class.getName());
  }
}
