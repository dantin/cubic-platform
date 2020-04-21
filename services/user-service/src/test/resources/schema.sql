-- t_users
CREATE TABLE IF NOT EXISTS t_users (
    id                      VARCHAR(256) PRIMARY KEY,
    username                VARCHAR(256),
    password                VARCHAR(256),
    create_at               TIMESTAMP,
    update_at               TIMESTAMP,
    enabled                 TINYINT(1),
    UNIQUE KEY unique_username(username)
);

-- t_authorities
CREATE TABLE IF NOT EXISTS t_authorities (
    username                VARCHAR(256) NOT NULL,
    authority               VARCHAR(256) NOT NULL,
    PRIMARY KEY(username, authority)
);
