package com.github.dantin.cubic.shared.base;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

public class NetworkHelper {

  /* Pre-loaded local address */
  private static InetAddress localAddress;

  static {
    try {
      localAddress = retrieveLocalInetAddress();
    } catch (SocketException e) {
      throw new RuntimeException("fail to get local IP address");
    }
  }

  private NetworkHelper() {
    // suppress default constructor for non-instantiable.
    throw new AssertionError();
  }

  /**
   * Get the first valid local IP address (The Public and LAN IP address are considered invalid).
   */
  public static InetAddress getLocalInetAddress() {
    return localAddress;
  }

  /**
   * Retrieve the first valid local IP address (The Public and LAN IP address are considered
   * invalid).
   *
   * @return local address
   * @throws SocketException socket exception
   */
  private static InetAddress retrieveLocalInetAddress() throws SocketException {
    // enumerate all network interfaces
    Enumeration<NetworkInterface> niEnum = NetworkInterface.getNetworkInterfaces();

    while (niEnum.hasMoreElements()) {
      NetworkInterface ni = niEnum.nextElement();
      if (ni.isLoopback()) {
        continue;
      }

      Enumeration<InetAddress> addrEnum = ni.getInetAddresses();
      while (addrEnum.hasMoreElements()) {
        InetAddress address = addrEnum.nextElement();

        // ignore all invalid address
        if (address.isLinkLocalAddress()
            || address.isLoopbackAddress()
            || address.isAnyLocalAddress()) {
          continue;
        }

        return address;
      }
    }

    throw new RuntimeException("NO valid local address");
  }

  /**
   * Retrieve local address.
   *
   * @return local address
   */
  public static String getLocalAddress() {
    return localAddress.getHostAddress();
  }
}
