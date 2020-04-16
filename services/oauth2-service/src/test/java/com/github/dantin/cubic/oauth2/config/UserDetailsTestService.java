package com.github.dantin.cubic.oauth2.config;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ActiveProfiles;

@Service
@ActiveProfiles("test")
public class UserDetailsTestService implements UserDetailsService {

  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    return new User(
        "root", "password", true, true, true, true, AuthorityUtils.createAuthorityList("USER"));
  }
}
