\connect oauth2_db;

INSERT INTO oauth_client_details (client_id, client_secret, scope, authorized_grant_types, authorities, access_token_validity) VALUES
('ultrasound_service', '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', 'read,write', 'password,refresh_token,client_credentials', 'ROLE_CLIENT', 300);
