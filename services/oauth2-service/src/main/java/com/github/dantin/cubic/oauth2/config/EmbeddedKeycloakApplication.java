package com.github.dantin.cubic.oauth2.config;

import com.github.dantin.cubic.oauth2.config.KeycloakServerProperties.AdminUser;
import org.keycloak.models.KeycloakSession;
import org.keycloak.representations.idm.RealmRepresentation;
import org.keycloak.services.managers.ApplianceBootstrap;
import org.keycloak.services.managers.RealmManager;
import org.keycloak.services.resources.KeycloakApplication;
import org.keycloak.util.JsonSerialization;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class EmbeddedKeycloakApplication extends KeycloakApplication {

  private static final Logger LOGGER = LoggerFactory.getLogger(EmbeddedKeycloakApplication.class);

  static KeycloakServerProperties keycloakServerProperties;

  public EmbeddedKeycloakApplication() {
    super();
    createMasterRealmAdminUser();
    // createBasicRealm();
  }

  private void createMasterRealmAdminUser() {
    KeycloakSession session = getSessionFactory().create();
    ApplianceBootstrap applianceBootstrap = new ApplianceBootstrap(session);
    AdminUser admin = keycloakServerProperties.getAdminUser();
    try {
      session.getTransactionManager().begin();
      applianceBootstrap.createMasterRealmUser(admin.getUsername(), admin.getPassword());
      session.getTransactionManager().commit();
    } catch (Exception e) {
      LOGGER.warn("couldn't create keycloak master admin user", e);
      session.getTransactionManager().rollback();
    }
    session.close();
  }

  private void createBasicRealm() {
    KeycloakSession session = getSessionFactory().create();
    try {
      session.getTransactionManager().begin();
      RealmManager manager = new RealmManager(session);
      Resource realmImportFile =
          new ClassPathResource(keycloakServerProperties.getRealmImportFile());
      manager.importRealm(
          JsonSerialization.readValue(realmImportFile.getInputStream(), RealmRepresentation.class));
      session.getTransactionManager().commit();
    } catch (Exception e) {
      LOGGER.warn("fail to import realm json file", e);
      session.getTransactionManager().rollback();
    }
    session.close();
  }
}
