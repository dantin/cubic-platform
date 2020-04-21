INSERT INTO t_users (id, username, password, create_at, update_at, enabled) VALUES
('1',  'root',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1);

INSERT INTO t_authorities (username, authority) VALUES
('root', 'ROLE_ROOT');
