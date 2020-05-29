package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.api.ultrasound.service.AuthService;
import com.github.dantin.cubic.base.exception.BusinessException;
import com.github.dantin.cubic.protocol.ultrasound.LoginRequest;
import com.github.dantin.cubic.protocol.ultrasound.RefreshTokenRequest;
import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import org.keycloak.KeycloakSecurityContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController extends BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);

  private final AuthService authService;

  public AuthController(HttpServletRequest request, AuthService authService) {
    super(request);
    this.authService = authService;
  }

  @PostMapping("/login")
  public ResponseEntity<String> login(@RequestBody LoginRequest request) {
    LOGGER.info("user '{}' login", request.getUsername());
    try {
      String body = authService.login(request.getUsername(), request.getPassword());
      return ResponseEntity.ok(body);
    } catch (BusinessException e) {
      LOGGER.warn("login failed", e);
      return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }
  }

  @PostMapping("/refresh")
  @RolesAllowed({"ultrasound-user", "ultrasound-admin", "ultrasound-root"})
  public ResponseEntity<String> refreshToken(@RequestBody RefreshTokenRequest request) {
    String username = super.getUsername();
    LOGGER.info("refresh token triggered by '{}'", username);
    try {
      String body = authService.refreshToken(request.getRefreshToken());
      return ResponseEntity.ok(body);
    } catch (BusinessException e) {
      LOGGER.warn("refresh token failed", e);
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }
  }

  @PostMapping("/logout")
  @RolesAllowed({"ultrasound-user", "ultrasound-admin", "ultrasound-root"})
  public ResponseEntity<String> logout(@RequestBody RefreshTokenRequest request) {
    String username = super.getUsername();
    LOGGER.info("logout triggered by '{}'", username);
    KeycloakSecurityContext context = getKeycloakSecurityContext();

    try {
      authService.logout(context.getTokenString(), request.getRefreshToken());
      return ResponseEntity.ok().build();
    } catch (BusinessException e) {
      LOGGER.warn("refresh token failed", e);
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }
  }
}
