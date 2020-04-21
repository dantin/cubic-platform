package com.github.dantin.cubic.user.repository;

import com.github.dantin.cubic.user.entity.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserMapper {

  /**
   * Find {@code User} by username.
   *
   * @param username username
   * @return founded user
   */
  User findByUsername(String username);

  /**
   * Save {@code User}.
   *
   * @param user user entity
   */
  void save(User user);

  /**
   * Delete {@code User}.
   *
   * @param id user id
   */
  void deleteById(String id);
}
