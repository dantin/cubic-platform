package com.github.dantin.cubic.api.ultrasound.service;

public interface AuthService {

  String login(String username, String password);

  String refreshToken(String refreshToken);

  void logout(String accessToken, String refreshToken);

  int getExpires(String jsonString);
}
