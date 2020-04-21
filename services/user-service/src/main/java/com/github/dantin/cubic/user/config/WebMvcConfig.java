package com.github.dantin.cubic.user.config;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import java.util.List;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/** Spring web mvc configuration. */
@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {

  @Override
  public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
    converters.add(
        new MappingJackson2HttpMessageConverter(
            new Jackson2ObjectMapperBuilder().serializationInclusion(Include.NON_NULL).build()));
  }
}
