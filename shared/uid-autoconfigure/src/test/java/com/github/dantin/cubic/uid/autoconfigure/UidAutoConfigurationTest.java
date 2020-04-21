package com.github.dantin.cubic.uid.autoconfigure;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertTrue;

import com.github.dantin.cubic.uid.UidGenerator;
import com.github.dantin.cubic.uid.autoconfigure.helper.CachedUidGeneratorAdapter;
import com.github.dantin.cubic.uid.autoconfigure.helper.DefaultUidGeneratorAdapter;
import org.junit.Test;
import org.springframework.boot.autoconfigure.AutoConfigurations;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;

/** Unit test for {@link UidAutoConfiguration}. */
public class UidAutoConfigurationTest {

  private final ApplicationContextRunner contextRunner =
      new ApplicationContextRunner()
          .withConfiguration(AutoConfigurations.of(UidAutoConfiguration.class));

  @Test
  public void testDefaultUidGenerator() {
    this.contextRunner.run(
        (context -> {
          UidGenerator uidGenerator = context.getBean(UidGenerator.class);
          assertThat(uidGenerator).isInstanceOf(DefaultUidGeneratorAdapter.class);
          assertTrue(uidGenerator.getUID() > 0L);
        }));
  }

  @Test
  public void testCachedUidGenerator() {
    this.contextRunner
        .withPropertyValues("customized.uid.generator-strategy:cached")
        .run(
            (context -> {
              UidGenerator uidGenerator = context.getBean(UidGenerator.class);
              assertThat(uidGenerator).isInstanceOf(CachedUidGeneratorAdapter.class);
              assertTrue(uidGenerator.getUID() > 0L);
            }));
  }
}
