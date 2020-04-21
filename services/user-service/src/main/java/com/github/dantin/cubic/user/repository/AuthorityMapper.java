package com.github.dantin.cubic.user.repository;

import com.github.dantin.cubic.user.entity.model.Authority;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AuthorityMapper {

  /**
   * Find {@code Authorty} by username.
   *
   * @param username username
   * @return found authority
   */
  Authority findByUsername(String username);

  /**
   * Save {@code Authority}.
   *
   * @param authority user authority
   */
  void save(Authority authority);
}
