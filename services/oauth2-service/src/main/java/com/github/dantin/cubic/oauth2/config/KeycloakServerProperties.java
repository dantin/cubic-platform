package com.github.dantin.cubic.oauth2.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "keycloak.server")
public class KeycloakServerProperties {

  private String contextPath = "/auth";

  private String realmImportFile = "realm.json";

  AdminUser adminUser = new AdminUser();

  public String getContextPath() {
    return contextPath;
  }

  public void setContextPath(String contextPath) {
    this.contextPath = contextPath;
  }

  public String getRealmImportFile() {
    return realmImportFile;
  }

  public void setRealmImportFile(String realmImportFile) {
    this.realmImportFile = realmImportFile;
  }

  public AdminUser getAdminUser() {
    return adminUser;
  }

  public void setAdminUser(AdminUser adminUser) {
    this.adminUser = adminUser;
  }

  public static class AdminUser {
    private String username = "admin";
    private String password = "password";

    public String getUsername() {
      return username;
    }

    public void setUsername(String username) {
      this.username = username;
    }

    public String getPassword() {
      return password;
    }

    public void setPassword(String password) {
      this.password = password;
    }
  }
}
