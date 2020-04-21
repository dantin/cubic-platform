package com.github.dantin.cubic.oauth2.service;

import com.github.dantin.cubic.protocol.user.UserDto;
import java.util.Objects;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

  private final RestTemplate restTemplate;

  public UserDetailsServiceImpl(RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    ResponseEntity<UserDto> userResponse =
        restTemplate.exchange(
            "http://user-service/users/" + username, HttpMethod.GET, null, UserDto.class);
    if (!userResponse.getStatusCode().is2xxSuccessful() || Objects.isNull(userResponse.getBody())) {
      throw new UsernameNotFoundException("user " + username + " not found");
    }
    UserDto user = userResponse.getBody();
    return new User(
        user.getUsername(),
        user.getPassword(),
        user.getEnabled(),
        true,
        true,
        true,
        AuthorityUtils.createAuthorityList(user.getRole()));
  }
}
