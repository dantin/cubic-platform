CREATE DATABASE user_db WITH ENCODING='utf-8';
GRANT ALL PRIVILEGES ON DATABASE user_db TO postgres;

\connect user_db;

-- t_users
CREATE TABLE IF NOT EXISTS t_users (
    id                      VARCHAR(256) PRIMARY KEY,
    username                VARCHAR(256),
    password                VARCHAR(256),
    create_at               TIMESTAMP,
    update_at               TIMESTAMP,
    enabled                 SMALLINT,
    UNIQUE (username)
);

-- t_authorities
CREATE TABLE IF NOT EXISTS t_authorities (
    username                VARCHAR(256) NOT NULL,
    authority               VARCHAR(256) NOT NULL,
    PRIMARY KEY(username, authority)
);
