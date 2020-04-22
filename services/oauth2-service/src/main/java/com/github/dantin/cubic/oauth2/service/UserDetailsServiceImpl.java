package com.github.dantin.cubic.oauth2.service;

import com.github.dantin.cubic.protocol.user.UserDto;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

  private static final Logger LOGGER = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

  private final RestTemplate restTemplate;

  public UserDetailsServiceImpl(RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    ResponseEntity<UserDto> response =
        restTemplate.exchange(
            "http://user-service/users/" + username, HttpMethod.GET, null, UserDto.class);
    if (!response.getStatusCode().is2xxSuccessful() || Objects.isNull(response.getBody())) {
      LOGGER.warn("user-service went wrong with http status code {}", response.getStatusCode());
      throw new UsernameNotFoundException("user " + username + " not found");
    }
    UserDto entity = response.getBody();
    return new User(
        entity.getUsername(),
        entity.getPassword(),
        entity.getEnabled(),
        true,
        true,
        true,
        AuthorityUtils.createAuthorityList(entity.getRole()));
  }
}
