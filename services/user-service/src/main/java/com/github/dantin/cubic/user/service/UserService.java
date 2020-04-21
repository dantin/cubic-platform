package com.github.dantin.cubic.user.service;

import com.github.dantin.cubic.user.entity.model.User;

public interface UserService {

  void save(User user);

  User loadUserByUsername(String username);
}
