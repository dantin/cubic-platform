\connect user_db;

INSERT INTO t_users (id, username, password, create_at, update_at, enabled) VALUES
('1',  'root',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('2',  'admin',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('3',  'room01',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('4',  'room02',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('5',  'room03',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('6',  'room04',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('7',  'room05',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('8',  'room06',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('9',  'room07',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1),
('10',  'room08',   '{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq', '2019-12-23 15:03:31.024', '2019-12-23 15:03:31.024', 1);

INSERT INTO t_authorities (username, authority) VALUES
('root', 'ROLE_ROOT'),
('admin', 'ROLE_ADMIN'),
('room01', 'ROLE_USER'),
('room02', 'ROLE_USER'),
('room03', 'ROLE_USER'),
('room04', 'ROLE_USER'),
('room05', 'ROLE_USER'),
('room06', 'ROLE_USER'),
('room07', 'ROLE_USER'),
('room08', 'ROLE_USER');
