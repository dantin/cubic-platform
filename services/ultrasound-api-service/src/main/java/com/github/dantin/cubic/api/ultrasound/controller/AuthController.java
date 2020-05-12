package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.api.ultrasound.service.AuthService;
import com.github.dantin.cubic.base.exception.BusinessException;
import com.github.dantin.cubic.protocol.ultrasound.LoginRequest;
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
public class AuthController {

  private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);

  private final AuthService authService;

  public AuthController(AuthService authService) {
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
}
