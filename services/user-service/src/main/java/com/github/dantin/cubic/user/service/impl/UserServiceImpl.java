package com.github.dantin.cubic.user.service.impl;

import com.github.dantin.cubic.uid.UidGenerator;
import com.github.dantin.cubic.user.entity.Role;
import com.github.dantin.cubic.user.entity.model.Authority;
import com.github.dantin.cubic.user.entity.model.User;
import com.github.dantin.cubic.user.repository.AuthorityMapper;
import com.github.dantin.cubic.user.repository.UserMapper;
import com.github.dantin.cubic.user.service.UserService;
import java.util.Date;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@CacheConfig(cacheNames = "userCache")
public class UserServiceImpl implements UserService {
  private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);

  private final UidGenerator uidGenerator;
  private final PasswordEncoder passwordEncoder;
  private final UserMapper userMapper;
  private final AuthorityMapper authorityMapper;

  public UserServiceImpl(
      // On test profile, `@ConditionalOnMissingBean` was resolved before JAR libs, mark `@Lazy`
      // here to avoid injection error.
      @Lazy UidGenerator uidGenerator,
      PasswordEncoder passwordEncoder,
      UserMapper userMapper,
      AuthorityMapper authorityMapper) {
    this.uidGenerator = uidGenerator;
    this.passwordEncoder = passwordEncoder;
    this.userMapper = userMapper;
    this.authorityMapper = authorityMapper;
  }

  @Transactional
  @Override
  public void save(User entity) {
    LOGGER.info("add new user, username {}", entity.getUsername());
    User existingUser = userMapper.findByUsername(entity.getUsername());
    if (Objects.nonNull(existingUser)) {
      LOGGER.warn("user {} already exists", entity.getUsername());
      throw new RuntimeException("user already exists");
    }
    long now = System.currentTimeMillis();
    User user = new User();
    user.setId(String.valueOf(uidGenerator.getUID()));
    user.setUsername(entity.getUsername());
    // encode raw password
    user.setPassword(passwordEncoder.encode(entity.getPassword()));
    user.setRole(Role.USER.toString());
    user.setCreateAt(new Date(now));
    user.setUpdateAt(new Date(now));
    userMapper.save(user);

    Role role = Role.from(entity.getRole());
    if (role == Role.UNKNOWN) {
      LOGGER.warn("bad role {} for {}", entity.getRole(), entity.getUsername());
      throw new RuntimeException("bad role value");
    }
    authorityMapper.save(new Authority(user.getUsername(), role.toString()));
  }

  @Cacheable(key = "#username")
  @Transactional(readOnly = true)
  @Override
  public User loadUserByUsername(String username) {
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("retrieve {} from database", username);
    }
    User user = userMapper.findByUsername(username);
    Authority authority = authorityMapper.findByUsername(username);
    if (Objects.isNull(user) || Objects.isNull(authority)) {
      throw new RuntimeException("user or authority not exist");
    }
    user.setRole(authority.getAuthority());
    return user;
  }
}
