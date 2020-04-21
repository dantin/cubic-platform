package com.github.dantin.cubic.uid.autoconfigure.helper;

import com.github.dantin.cubic.uid.CachedUidGenerator;
import com.github.dantin.cubic.uid.UidGenerator;
import com.github.dantin.cubic.uid.autoconfigure.UidProperties;
import com.github.dantin.cubic.uid.exception.UidGenerateException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.util.Assert;

public class CachedUidGeneratorAdapter implements UidGenerator, DisposableBean {

  private UidGenerator uidGenerator;

  public CachedUidGeneratorAdapter(UidProperties uidProperties) {
    Assert.isTrue(uidProperties.getWorkerId() >= 0, "worker id must be 0 or positive");
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
  }

  @Override
  public long getUID() throws UidGenerateException {
    return this.uidGenerator.getUID();
  }

  @Override
  public String parseUID(long uid) {
    return this.uidGenerator.parseUID(uid);
  }

  @Override
  public void destroy() throws Exception {
    CachedUidGenerator cachedUidGenerator = (CachedUidGenerator) this.uidGenerator;
    cachedUidGenerator.destroy();
  }
}
