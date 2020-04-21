package com.github.dantin.cubic.user.controller;

import com.github.dantin.cubic.user.entity.model.User;
import com.github.dantin.cubic.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class UserController {

  private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

  private final UserService userService;

  public UserController(UserService userService) {
    this.userService = userService;
  }

  @GetMapping("/{username}")
  public ResponseEntity<User> loadUserByUsername(@PathVariable("username") String username) {
    LOGGER.info("load user by username {}", username);
    try {
      User user = this.userService.loadUserByUsername(username);
      return ResponseEntity.ok(user);
    } catch (RuntimeException e) {
      LOGGER.warn("fail to load user", e);
      return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).build();
    }
  }
}
