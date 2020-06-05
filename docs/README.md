# Data

Rebuild schema:

    drop database db_name
    sql -d db_name -f db.sql

Export Keycloak data:

    docker exec -it ultrasound-platform_keycloak_1 /opt/jboss/keycloak/bin/standalone.sh \
      -Djboss.socket.binding.port-offset=100 -Dkeycloak.migration.action=export \
      -Dkeycloak.migration.provider=singleFile \
      -Dkeycloak.migration.realmName=ultrasound \
      -Dkeycloak.migration.usersExportStrategy=REALM_FILE \
      -Dkeycloak.migration.file=/tmp/ultrasound_realm.json
