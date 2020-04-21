package com.github.dantin.cubic.user.config;

import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceBuilder;
import javax.sql.DataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

/** Druid configuration */
@Configuration
public class DruidConfig {

  private static final Logger LOGGER = LoggerFactory.getLogger(DruidConfig.class);

  @Deprecated
  DataSource dataSource() {
    LOGGER.info("init DruidDataSource");
    return DruidDataSourceBuilder.create().build();
  }
}
