INSERT INTO oauth_client_details (client_id, client_secret, scope, authorized_grant_types, authorities, access_token_validity) VALUES
('dummy_client', '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', 'read,write', 'password,refresh_token,client_credentials', 'ROLE_CLIENT', 300);

INSERT INTO users (id, username, password, create_at, update_at, enabled) VALUES
('1',  'root',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1);

INSERT INTO authorities (username, authority) VALUES
('root', 'ROLE_ROOT');
