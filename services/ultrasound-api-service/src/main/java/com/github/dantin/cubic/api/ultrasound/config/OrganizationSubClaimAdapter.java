package com.github.dantin.cubic.api.ultrasound.config;

import java.util.Collections;
import java.util.Map;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.oauth2.jwt.MappedJwtClaimSetConverter;

public class OrganizationSubClaimAdapter
    implements Converter<Map<String, Object>, Map<String, Object>> {

  private final MappedJwtClaimSetConverter delegate =
      MappedJwtClaimSetConverter.withDefaults(Collections.emptyMap());

  @Override
  public Map<String, Object> convert(Map<String, Object> source) {
    Map<String, Object> convertedClaims = this.delegate.convert(source);
    String organization = (String) convertedClaims.getOrDefault("organization", "unknown");
    convertedClaims.put("organization", organization);
    return convertedClaims;
  }
}
