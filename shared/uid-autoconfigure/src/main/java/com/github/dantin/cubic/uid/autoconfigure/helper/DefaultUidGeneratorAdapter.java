package com.github.dantin.cubic.uid.autoconfigure.helper;

import com.github.dantin.cubic.uid.DefaultUidGenerator;
import com.github.dantin.cubic.uid.UidGenerator;
import com.github.dantin.cubic.uid.autoconfigure.UidProperties;
import com.github.dantin.cubic.uid.exception.UidGenerateException;
import org.springframework.util.Assert;

public class DefaultUidGeneratorAdapter implements UidGenerator {

  private final UidGenerator uidGenerator;

  public DefaultUidGeneratorAdapter(UidProperties uidProperties) {
    Assert.isTrue(uidProperties.getWorkerId() >= 0, "worker id must be 0 or positive");

    DefaultUidGenerator.DefaultUidGeneratorBuilder builder =
        UidGenerator.defaultUidGeneratorBuilder(uidProperties.getWorkerId());
    this.uidGenerator =
        builder
            .timeBits(uidProperties.getTimeBits())
            .workerBits(uidProperties.getWorkerBits())
            .seqBits(uidProperties.getSeqBits())
            .epoch(uidProperties.getEpoch())
            .build();
  }

  @Override
  public long getUID() throws UidGenerateException {
    return this.uidGenerator.getUID();
  }

  @Override
  public String parseUID(long uid) {
    return this.uidGenerator.parseUID(uid);
  }
}
