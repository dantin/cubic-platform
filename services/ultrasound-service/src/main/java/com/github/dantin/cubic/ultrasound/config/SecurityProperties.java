package com.github.dantin.cubic.ultrasound.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.core.io.Resource;

@ConfigurationProperties("security.oauth2")
public class SecurityProperties {

  private JwtProperties jwt;

  public JwtProperties getJwt() {
    return jwt;
  }

  public void setJwt(JwtProperties jwt) {
    this.jwt = jwt;
  }

  public static class JwtProperties {
    private Resource publicKey;

    public Resource getPublicKey() {
      return publicKey;
    }

    public void setPublicKey(Resource publicKey) {
      this.publicKey = publicKey;
    }
  }
}
