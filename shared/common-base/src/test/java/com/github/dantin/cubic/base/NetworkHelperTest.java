package com.github.dantin.cubic.base;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;

/** Unit test for {@link NetworkHelper}. */
public class NetworkHelperTest {

  @Test
  public void testGetLocalAddress() {
    assertNotNull(NetworkHelper.getLocalInetAddress());
  }
}
