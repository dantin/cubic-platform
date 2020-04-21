package com.github.dantin.cubic.uid.autoconfigure;

import com.google.common.base.Strings;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/** The configuration of UID. */
@Configuration
@ConfigurationProperties(prefix = "customized.uid")
@SuppressWarnings("SpringFacetCodeInspection")
public class UidProperties {

  private Long workerId = 1L;
  private Integer timeBits = 28;
  private Integer workerBits = 22;
  private Integer seqBits = 13;
  private String epoch = "2016-05-20";
  private GeneratorStrategy generatorStrategy = GeneratorStrategy.DEFAULT;

  private CachedSetting cachedSetting = new CachedSetting();

  public UidProperties() {}

  public Integer getTimeBits() {
    return timeBits;
  }

  public void setTimeBits(Integer timeBits) {
    if (timeBits > 0) {
      this.timeBits = timeBits;
    }
  }

  public Integer getWorkerBits() {
    return workerBits;
  }

  public void setWorkerBits(Integer workerBits) {
    if (workerBits > 0) {
      this.workerBits = workerBits;
    }
  }

  public Integer getSeqBits() {
    return seqBits;
  }

  public void setSeqBits(Integer seqBits) {
    if (seqBits > 0) {
      this.seqBits = seqBits;
    }
  }

  public String getEpoch() {
    return epoch;
  }

  public void setEpoch(String epoch) {
    if (!Strings.isNullOrEmpty(epoch)) {
      this.epoch = epoch;
    }
  }

  public Long getWorkerId() {
    return workerId;
  }

  public void setWorkerId(Long workerId) {
    this.workerId = workerId;
  }

  public CachedSetting getCachedSetting() {
    return cachedSetting;
  }

  public void setCachedSetting(CachedSetting cachedSetting) {
    this.cachedSetting = cachedSetting;
  }

  public GeneratorStrategy getGeneratorStrategy() {
    return generatorStrategy;
  }

  public void setGeneratorStrategy(GeneratorStrategy generatorStrategy) {
    this.generatorStrategy = generatorStrategy;
  }

  public static class CachedSetting {
    private Integer boostPower = 32;
    private Integer paddingFactor = 80;
    private Long scheduleInterval = 60L;

    public Integer getBoostPower() {
      return boostPower;
    }

    public void setBoostPower(Integer boostPower) {
      this.boostPower = boostPower;
    }

    public Integer getPaddingFactor() {
      return paddingFactor;
    }

    public void setPaddingFactor(Integer paddingFactor) {
      this.paddingFactor = paddingFactor;
    }

    public Long getScheduleInterval() {
      return scheduleInterval;
    }

    public void setScheduleInterval(Long scheduleInterval) {
      this.scheduleInterval = scheduleInterval;
    }
  }

  /** Strategies for Unique ID Generator. */
  public enum GeneratorStrategy {
    /** Default strategy */
    DEFAULT,
    /** Cached strategy */
    CACHED;
  }
}
