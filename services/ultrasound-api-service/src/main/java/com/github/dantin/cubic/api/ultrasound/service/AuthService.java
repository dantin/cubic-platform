package com.github.dantin.cubic.api.ultrasound.service;

import java.util.Map;

public interface AuthService {

  Map<String, Object> login(String username, String password);

  Map<String, Object> refreshToken(String refreshToken);

  void logout(String accessToken, String refreshToken);
}
