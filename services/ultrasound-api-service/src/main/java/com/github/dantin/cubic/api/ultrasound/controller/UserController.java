package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.base.CollectionsHelper;
import java.util.Map;
import java.util.Set;
import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController extends BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

  @Autowired
  public UserController(HttpServletRequest request) {
    super(request);
  }

  @GetMapping("/profile")
  @RolesAllowed({"ultrasound-user", "ultrasound-admin", "ultrasound-root"})
  public ResponseEntity<Map<String, Object>> profile() {
    LOGGER.debug("load user profile");

    String username = super.getUsername();
    LOGGER.debug("found user '{}' in security context", username);
    Set<String> roles = super.getResourceAccess();

    return ResponseEntity.ok(
        CollectionsHelper.mapOf("username", username, "roles", String.join(",", roles)));
  }
}
