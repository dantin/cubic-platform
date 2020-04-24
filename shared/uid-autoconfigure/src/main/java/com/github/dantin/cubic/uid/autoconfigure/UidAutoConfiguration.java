package com.github.dantin.cubic.uid.autoconfigure;

import com.github.dantin.cubic.uid.CachedUidGenerator;
import com.github.dantin.cubic.uid.DefaultUidGenerator;
import com.github.dantin.cubic.uid.UidGenerator;
import com.github.dantin.cubic.uid.autoconfigure.UidProperties.GeneratorStrategy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.Assert;

/** The automatic configuration for UID. */
@Configuration
@EnableConfigurationProperties(UidProperties.class)
public class UidAutoConfiguration implements DisposableBean {

  private static final Logger LOGGER = LoggerFactory.getLogger(UidAutoConfiguration.class);

  private final UidProperties uidProperties;

  private UidGenerator uidGenerator;

  public UidAutoConfiguration(UidProperties uidProperties) {
    this.uidProperties = uidProperties;
  }

  @ConditionalOnMissingBean(UidGenerator.class)
  @Bean
  public UidGenerator uidGenerator() {
    Assert.isTrue(uidProperties.getWorkerId() >= 0, "worker id must be 0 or positive");

    if (uidProperties.getGeneratorStrategy() == GeneratorStrategy.CACHED) {
      CachedUidGenerator.CachedUidGeneratorBuilder builder =
          UidGenerator.cachedUidGeneratorBuilder(uidProperties.getWorkerId());
      builder =
          builder
              .timeBits(uidProperties.getTimeBits())
              .workerBits(uidProperties.getWorkerBits())
              .seqBits(uidProperties.getSeqBits())
              .epoch(uidProperties.getEpoch())
              .boostPower(uidProperties.getCachedSetting().getBoostPower())
              .paddingFactor(uidProperties.getCachedSetting().getPaddingFactor())
              .scheduleInterval(uidProperties.getCachedSetting().getScheduleInterval());
      this.uidGenerator = builder.build();
      return uidGenerator;
    }
    DefaultUidGenerator.DefaultUidGeneratorBuilder builder =
        UidGenerator.defaultUidGeneratorBuilder(uidProperties.getWorkerId());
    this.uidGenerator =
        builder
            .timeBits(uidProperties.getTimeBits())
            .workerBits(uidProperties.getWorkerBits())
            .seqBits(uidProperties.getSeqBits())
            .epoch(uidProperties.getEpoch())
            .build();
    return uidGenerator;
  }

  @Override
  public void destroy() throws Exception {
    if (this.uidGenerator instanceof CachedUidGenerator) {
      LOGGER.info("destroy cached uid generator");
      CachedUidGenerator cachedUidGenerator = (CachedUidGenerator) this.uidGenerator;
      cachedUidGenerator.destroy();
    } else {
      LOGGER.info("destroy default uid generator");
    }
  }
}
