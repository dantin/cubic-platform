package com.github.dantin.cubic.shm.remote;

import java.io.IOException;
import java.net.URI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpRequest;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.http.client.support.HttpRequestWrapper;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

@Component
public class AuthenticationInterceptor implements ClientHttpRequestInterceptor {
  private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticationInterceptor.class);

  private final MediaServiceClient mediaClient;

  public AuthenticationInterceptor(MediaServiceClient mediaServiceClient) {
    this.mediaClient = mediaServiceClient;
  }

  @Override
  public ClientHttpResponse intercept(
      HttpRequest request, byte[] body, ClientHttpRequestExecution execution) throws IOException {
    String url = request.getURI().getPath();
    String method = request.getMethodValue();

    if (!(MediaServiceClient.AUTH_PATH.equalsIgnoreCase(url) && HttpMethod.POST.matches(method))) {
      String token = mediaClient.getToken();
      if (LOGGER.isDebugEnabled()) {
        LOGGER.debug("authentication code: {}", token);
      }
      return execution.execute(new AuthHttpRequestWrapper(request, token), body);
    }

    return execution.execute(request, body);
  }

  private static class AuthHttpRequestWrapper extends HttpRequestWrapper {
    private final HttpRequest original;
    private final String token;

    public AuthHttpRequestWrapper(HttpRequest request, String token) {
      super(request);
      this.original = request;
      this.token = token;
    }

    @Override
    public URI getURI() {
      return UriComponentsBuilder.fromUri(original.getURI())
          .queryParam("key", token)
          .build()
          .toUri();
    }
  }
}
