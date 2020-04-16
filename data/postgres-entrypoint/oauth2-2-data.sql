\connect oauth2_db;

INSERT INTO oauth_client_details (client_id, client_secret, scope, authorized_grant_types, authorities, access_token_validity) VALUES
('ultrasound_service', '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', 'read,write', 'password,refresh_token,client_credentials', 'ROLE_CLIENT', 300);

INSERT INTO users (id, username, password, create_at, update_at, enabled) VALUES
('1',  'root',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('2',  'admin',  '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('11', 'room01', '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('12', 'room02', '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('13', 'room03', '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('14', 'room04', '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('15', 'room05', '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1);

INSERT INTO authorities (username, authority) VALUES
('root', 'ROLE_ROOT'),
('admin', 'ROLE_ADMIN'),
('room01', 'ROLE_USER'),
('room02', 'ROLE_USER'),
('room03', 'ROLE_USER'),
('room04', 'ROLE_USER'),
('room05', 'ROLE_USER');
