package com.github.dantin.cubic.uid.autoconfigure;

import com.github.dantin.cubic.uid.UidGenerator;
import com.github.dantin.cubic.uid.autoconfigure.helper.CachedUidGeneratorAdapter;
import com.github.dantin.cubic.uid.autoconfigure.helper.DefaultUidGeneratorAdapter;
import java.util.Objects;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

/** The automatic configuration for UID. */
@Configuration
@EnableConfigurationProperties(UidProperties.class)
public class UidAutoConfiguration {

  private final UidProperties uidProperties;

  public UidAutoConfiguration(UidProperties uidProperties) {
    this.uidProperties = uidProperties;
  }

  @Bean
  @ConditionalOnClass({UidGenerator.class})
  @ConditionalOnMissingBean
  UidGenerator uidGenerator(Environment env) {
    if (!Objects.isNull(uidProperties.getCachedSetting().getBoostPower())
        && !Objects.isNull(uidProperties.getCachedSetting().getPaddingFactor())
        && !Objects.isNull(uidProperties.getCachedSetting().getScheduleInterval())) {
      return new CachedUidGeneratorAdapter(uidProperties);
    }
    return new DefaultUidGeneratorAdapter(uidProperties);
  }
}
