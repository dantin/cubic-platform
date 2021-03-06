CREATE DATABASE room_db WITH ENCODING='utf-8';
GRANT ALL PRIVILEGES ON DATABASE room_db TO postgres;

\connect room_db;

-- t_room
CREATE TABLE IF NOT EXISTS t_room (
    id VARCHAR(32) NOT NULL,
    name VARCHAR(255) NOT NULL,
    create_at TIMESTAMP NOT NULL,
    PRIMARY KEY (id)
);

-- t_room_allocation
CREATE TABLE IF NOT EXISTS t_room_allocation (
    username VARCHAR(32) NOT NULL,
    room_id VARCHAR(32) NOT NULL,
    PRIMARY KEY(username, room_id)
);

-- t_stream
CREATE TABLE IF NOT EXISTS t_stream (
    id VARCHAR(32) NOT NULL,
    type VARCHAR(32) NOT NULL,
    scope VARCHAR(32) NOT NULL,
    protocol VARCHAR(16) NOT NULL,
    host VARCHAR(255) NOT NULL,
    port INTEGER NOT NULL,
    path VARCHAR(255) NOT NULL,
    create_at TIMESTAMP NOT NULL,
    room_id VARCHAR(32) NOT NULL,
    PRIMARY KEY (id)
);
