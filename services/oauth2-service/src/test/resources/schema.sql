-- oauth_client_details
CREATE TABLE IF NOT EXISTS oauth_client_details (
    client_id               VARCHAR(256) PRIMARY KEY,
    resource_ids            VARCHAR(256),
    client_secret           VARCHAR(256) NOT NULL,
    scope                   VARCHAR(256),
    authorized_grant_types  VARCHAR(256),
    web_server_redirect_uri VARCHAR(256),
    authorities             VARCHAR(256),
    access_token_validity   INTEGER,
    refresh_token_validity  INTEGER,
    additional_information  VARCHAR(4096),
    autoapprove             VARCHAR(256)
);

-- oauth_client_token
CREATE TABLE IF NOT EXISTS oauth_client_token (
    token_id                VARCHAR(256),
    token                   BLOB,
    authentication_id       VARCHAR(256) PRIMARY KEY,
    user_name               VARCHAR(256),
    client_id               VARCHAR(256)
);

-- oauth_access_token
CREATE TABLE IF NOT EXISTS oauth_access_token (
    token_id                VARCHAR(256),
    token                   BLOB,
    authentication_id       VARCHAR(256) PRIMARY KEY,
    user_name               VARCHAR(256),
    client_id               VARCHAR(256),
    authentication          BLOB,
    refresh_token           VARCHAR(256)
);

-- oauth_refresh_token
CREATE TABLE IF NOT EXISTS oauth_refresh_token (
    token_id                VARCHAR(256),
    token                   BLOB,
    authentication          BLOB
);

-- oauth_code
CREATE TABLE IF NOT EXISTS oauth_code (
    code                    VARCHAR(256),
    authentication          BLOB
);

-- users
CREATE TABLE IF NOT EXISTS users (
    id                      VARCHAR(256) PRIMARY KEY,
    username                VARCHAR(256),
    password                VARCHAR(256),
    create_at               TIMESTAMP,
    update_at               TIMESTAMP,
    enabled                 TINYINT(1),
    UNIQUE KEY unique_username(username)
);

-- authorities
CREATE TABLE IF NOT EXISTS authorities (
    username                VARCHAR(256) NOT NULL,
    authority               VARCHAR(256) NOT NULL,
    PRIMARY KEY(username, authority)
);