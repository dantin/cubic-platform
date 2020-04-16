package com.github.dantin.cubic.ultrasound.controller;

import java.security.Principal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
public class UserController {

  private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

  @GetMapping("/profile")
  @PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_ROOT')")
  public ResponseEntity<Principal> profile(Principal principal) {
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("get user profile of '{}'", principal.getName());
    }
    return ResponseEntity.ok(principal);
  }
}
