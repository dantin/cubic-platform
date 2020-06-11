package com.github.dantin.cubic.api.ultrasound.controller;

import com.github.dantin.cubic.api.ultrasound.service.AuthService;
import com.github.dantin.cubic.base.ResultCode;
import com.github.dantin.cubic.base.exception.BusinessException;
import com.github.dantin.cubic.protocol.ResponseResult;
import com.github.dantin.cubic.protocol.ultrasound.LoginRequest;
import com.github.dantin.cubic.protocol.ultrasound.Token;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import org.keycloak.KeycloakSecurityContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
@ResponseResult
public class AuthController extends BaseController {

  private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);

  private final RedisTemplate<String, String> redisTemplate;
  private final AuthService authService;

  public AuthController(
      HttpServletRequest request,
      RedisTemplate<String, String> redisTemplate,
      AuthService authService) {
    super(request);
    this.redisTemplate = redisTemplate;
    this.authService = authService;
  }

  @PostMapping("/login")
  public Map<String, Object> login(@RequestBody LoginRequest request) {
    String username = request.getUsername();
    LOGGER.info("user '{}' login", username);

    if (Boolean.TRUE == redisTemplate.hasKey(username)) {
      throw new BusinessException("user already login", ResultCode.USER_IN_USE);
    }

    Map<String, Object> body = authService.login(username, request.getPassword());
    int expire = (Integer) body.get("expires_in");
    redisTemplate.opsForValue().set(username, username);
    redisTemplate.expire(username, expire, TimeUnit.SECONDS);
    return body;
  }

  @PostMapping("/refresh")
  @RolesAllowed({"ultrasound-user", "ultrasound-admin", "ultrasound-root"})
  public Map<String, Object> refreshToken(@RequestBody Token request) {
    String username = super.getUsername();
    KeycloakSecurityContext context = getKeycloakSecurityContext();
    LOGGER.info("refresh token triggered by '{}'", username);
    Map<String, Object> body = authService.refreshToken(request.getRefreshToken());
    int expire = (Integer) body.get("expires_in");
    redisTemplate.expire(username, expire, TimeUnit.SECONDS);
    return body;
  }

  @PostMapping("/logout")
  @RolesAllowed({"ultrasound-user", "ultrasound-admin", "ultrasound-root"})
  public void logout(@RequestBody Token request) {
    String username = super.getUsername();
    LOGGER.info("logout triggered by '{}'", username);
    KeycloakSecurityContext context = getKeycloakSecurityContext();

    authService.logout(context.getTokenString(), request.getRefreshToken());
    redisTemplate.delete(username);
  }
}
