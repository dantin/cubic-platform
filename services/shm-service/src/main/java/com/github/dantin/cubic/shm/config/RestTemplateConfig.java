package com.github.dantin.cubic.shm.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.base.CollectionsHelper;
import com.github.dantin.cubic.shm.remote.AuthenticationInterceptor;
import java.nio.charset.StandardCharsets;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import org.apache.http.Header;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultConnectionKeepAliveStrategy;
import org.apache.http.impl.client.DefaultHttpRequestRetryHandler;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicHeader;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.ssl.TrustStrategy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.DefaultResponseErrorHandler;
import org.springframework.web.client.RestTemplate;

/**
 * {@code RestTemplate} configuration
 *
 * <p>Since {@code RestTemplate} instances often need to be customized before being used, Spring
 * Boot does NOT provide andy single auto-configured {@code RestTemplate} bean.
 *
 * <p>See Also:
 * https://docs.spring.io/spring-boot/docs/current/reference/html/spring-boot-features.html#boot-features-resttemplate
 */
@Configuration
@EnableConfigurationProperties(MediaServerConfig.class)
public class RestTemplateConfig {
  private static final Logger LOGGER = LoggerFactory.getLogger(RestTemplateConfig.class);

  // connection creating timeout, in milliseconds
  private static int CONNECT_TIMEOUT = 20_000;
  // max waiting timeout if there is not enough connection available, in milliseconds
  private static int REQUEST_TIMEOUT = 20_000;
  // max RT timeout, in milliseconds
  private static int SOCKET_TIMEOUT = 30_000;
  // max connection counts per host
  private static int DEFAULT_MAX_PER_ROUTE = 100;
  // max connection counts total
  private static int MAX_TOTAL_CONNECTION = 300;

  private final AuthenticationInterceptor authenticationInterceptor;
  private final ObjectMapper objectMapper;

  public RestTemplateConfig(
      @Lazy AuthenticationInterceptor authenticationInterceptor, ObjectMapper objectMapper) {
    this.authenticationInterceptor = authenticationInterceptor;
    this.objectMapper = objectMapper;
  }

  /**
   * Customized REST Template.
   *
   * @return customized {@code RestTemplate}
   */
  @Bean
  public RestTemplate restTemplate() {
    // build REST Template using customized Client HTTP request factory.
    RestTemplate restTemplate = new RestTemplate(clientHttpRequestFactory());
    // setup message converter.
    restTemplate.setMessageConverters(messageConverters());
    // setup interceptor.
    restTemplate.getInterceptors().add(authenticationInterceptor);
    restTemplate.setErrorHandler(new DefaultResponseErrorHandler());
    return restTemplate;
  }

  /**
   * Customized Client HTTP request factory, using Apache Common Http Client.
   *
   * @return customized {@code HttpComponentsClientHttpRequestFactory}
   */
  private HttpComponentsClientHttpRequestFactory clientHttpRequestFactory() {
    SSLContextBuilder builder = new SSLContextBuilder();
    try {
      TrustStrategy acceptTrustStrategy =
          new TrustStrategy() {
            @Override
            public boolean isTrusted(X509Certificate[] chain, String authType)
                throws CertificateException {
              return true;
            }
          };
      builder.loadTrustMaterial(null, acceptTrustStrategy);
    } catch (Exception e) {
      LOGGER.error("Pooling Connection Manager initialization failed: " + e.getMessage(), e);
    }

    SSLConnectionSocketFactory socketFactory = null;
    try {
      socketFactory =
          new SSLConnectionSocketFactory(builder.build(), NoopHostnameVerifier.INSTANCE);
    } catch (KeyManagementException | NoSuchAlgorithmException e) {
      LOGGER.error("Pool Connection Manager initialization failed: " + e.getMessage(), e);
    }

    // register HTTP and HTTPS requests.
    Registry<ConnectionSocketFactory> registry =
        RegistryBuilder.<ConnectionSocketFactory>create()
            .register("http", PlainConnectionSocketFactory.getSocketFactory())
            .register("https", Objects.requireNonNull(socketFactory))
            .build();

    // Setup connection pool.
    PoolingHttpClientConnectionManager manager = new PoolingHttpClientConnectionManager(registry);
    manager.setMaxTotal(MAX_TOTAL_CONNECTION); // max total connection
    manager.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE); // max connection per route

    // Build HTTP Client.
    HttpClientBuilder httpClientBuilder = HttpClients.custom();
    httpClientBuilder.setSSLSocketFactory(socketFactory);
    httpClientBuilder.setConnectionManager(manager);
    httpClientBuilder.setConnectionManagerShared(true);
    // retry count, default: 3, disabled
    httpClientBuilder.setRetryHandler(new DefaultHttpRequestRetryHandler(3, true));
    // enable long connection, set Keep-Alive in header
    httpClientBuilder.setKeepAliveStrategy(DefaultConnectionKeepAliveStrategy.INSTANCE);
    // set customized HTTP header
    List<Header> headers = new ArrayList<>();
    headers.add(new BasicHeader("User-Agent", "control-client"));
    headers.add(new BasicHeader("Connection", "keep-alive"));
    httpClientBuilder.setDefaultHeaders(headers);
    // build up HTTP Client.
    CloseableHttpClient httpClient = httpClientBuilder.build();

    // Setup Client HTTP Request Factory.
    HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
    factory.setHttpClient(httpClient);
    factory.setConnectTimeout(CONNECT_TIMEOUT); // connection timeout
    factory.setReadTimeout(SOCKET_TIMEOUT); // response read timeout, a.k.a. Socket Timeout
    factory.setConnectionRequestTimeout(
        REQUEST_TIMEOUT); // max waiting time if the connection is not available
    factory.setBufferRequestBody(
        false); // buffer request body, default is true, disable here to avoid OOM

    return factory;
  }

  /**
   * Customized Message Converter, using Jackson as JSON decoder.
   *
   * @return {@code HttpMessageConverter} list
   */
  private List<HttpMessageConverter<?>> messageConverters() {
    List<HttpMessageConverter<?>> messageConverters = new ArrayList<>();
    MappingJackson2HttpMessageConverter jsonConverter = new MappingJackson2HttpMessageConverter();
    jsonConverter.setObjectMapper(objectMapper);
    jsonConverter.setSupportedMediaTypes(
        CollectionsHelper.listOf(
            new MediaType("text", "plain", StandardCharsets.UTF_8), MediaType.APPLICATION_JSON));
    messageConverters.add(jsonConverter);
    return messageConverters;
  }
}
