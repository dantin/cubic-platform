package com.github.dantin.cubic.ultrasound.config;

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
        "dummy_user",
        "{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq",
        true,
        true,
        true,
        true,
        AuthorityUtils.createAuthorityList("ROLE_USER"));
  }
}
