package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.base.CollectionsHelper;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

  private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

  @GetMapping("/profile")
  @PreAuthorize("hasAuthority('SCOPE_read')")
  public ResponseEntity<Map<String, Object>> profile(@AuthenticationPrincipal Jwt principal) {
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("get user profile of '{}'", principal.getClaimAsString("preferred_username"));
    }
    return ResponseEntity.ok(
        CollectionsHelper.mapOf(
            "username",
            principal.getClaimAsString("preferred_username"),
            "organization",
            principal.getClaimAsString("organization")));
  }
}
