package com.github.dantin.cubic.user.config;

import com.github.dantin.cubic.uid.UidGenerator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.ActiveProfiles;

@Configuration
@ActiveProfiles("test")
public class UidTestConfig {

  @Bean
  public UidGenerator uidGenerator() {
    return UidGenerator.defaultUidGeneratorBuilder(1).build();
  }
}
