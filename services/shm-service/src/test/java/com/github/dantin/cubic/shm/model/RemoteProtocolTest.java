package com.github.dantin.cubic.shm.model;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.everyItem;
import static org.hamcrest.Matchers.startsWith;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dantin.cubic.base.CollectionsHelper;
import com.github.dantin.cubic.shm.model.protocol.AuthenticationRequest;
import com.github.dantin.cubic.shm.model.protocol.AuthenticationResponse;
import com.github.dantin.cubic.shm.model.protocol.AuthenticationResponse.Content;
import com.github.dantin.cubic.shm.model.protocol.ListRouteResponse;
import com.github.dantin.cubic.shm.model.protocol.ListRouteResponse.Builder;
import com.github.dantin.cubic.shm.model.protocol.ListRouteResponse.Source;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;

public final class RemoteProtocolTest {
  private static final ObjectMapper MAPPER = new ObjectMapper();

  private <T> T validate(Object o, Class<T> clazz) {
    try {
      // serialize
      String json = MAPPER.writeValueAsString(o);
      // deserialize
      return MAPPER.readValue(json, clazz);
    } catch (JsonProcessingException e) {
      assertNull("serialize/deserialize error", e);
    }
    return null;
  }

  @Test
  public void testAuthenticationRequest() {
    String username = "test";
    String password = "password";
    AuthenticationRequest authenticationRequest =
        AuthenticationRequest.builder(username, password).build();

    assertThat(authenticationRequest.getUsername(), is(username));
    assertThat(authenticationRequest.getPassword(), is(password));

    AuthenticationRequest actual = validate(authenticationRequest, AuthenticationRequest.class);
    assertNotNull(actual);
    assertThat(actual.getUsername(), is(username));
    assertThat(actual.getPassword(), is(password));
  }

  @Test
  public void testAuthenticationResponse() {
    String states = "states";
    String api = "api";
    String auth = "auth";
    AuthenticationResponse authenticationResponse =
        AuthenticationResponse.builder()
            .states(states)
            .content(Content.builder().api(api).authentication(auth).build())
            .build();

    assertThat(authenticationResponse.getStates(), is(states));
    assertThat(authenticationResponse.getContent().getApi(), is(api));
    assertThat(authenticationResponse.getContent().getAuthentication(), is(auth));

    AuthenticationResponse actual = validate(authenticationResponse, AuthenticationResponse.class);
    assertNotNull(actual);
    assertThat(actual.getStates(), is(states));
    assertThat(actual.getContent().getAuthentication(), is(auth));
    assertThat(actual.getContent().getApi(), is(api));
  }

  @Test
  public void testListRouteResponse() {
    String states = "states";
    List<String> expectedNames = CollectionsHelper.listOf("name1", "name2");
    Builder builder = ListRouteResponse.builder().states(states).total(expectedNames.size());
    expectedNames.forEach(
        it -> {
          (builder).addSource(Source.builder().name(it).build());
        });
    ListRouteResponse listRouteResponse = builder.build();

    assertThat(listRouteResponse.getStates(), is(states));
    assertThat(listRouteResponse.getTotal(), is(expectedNames.size()));
    List<String> names = new ArrayList<>();
    listRouteResponse.getSources().forEach(r -> names.add(r.getName()));
    assertThat(names, everyItem(startsWith("name")));

    ListRouteResponse actual = validate(listRouteResponse, ListRouteResponse.class);
    assertNotNull(actual);
    assertThat(actual.getStates(), is(states));
    assertThat(actual.getTotal(), is(expectedNames.size()));
    names.clear();
    actual.getSources().forEach(r -> names.add(r.getName()));
    assertThat(names, everyItem(startsWith("name")));
  }
}
