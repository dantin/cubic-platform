\connect room_db;

INSERT INTO t_room(id, name, create_at) VALUES
('1', 'Room-01', '2019-12-23 15:03:31.024'),
('2', 'Room-02', '2019-12-23 15:03:31.024'),
('3', 'Room-03', '2019-12-23 15:03:31.024'),
('4', 'Room-04', '2019-12-23 15:03:31.024'),
('5', 'Room-05', '2019-12-23 15:03:31.024');

INSERT INTO t_room_allocation(username, room_id) VALUES
('room01', '1'),
('room02', '2'),
('room03', '3'),
('room04', '4'),
('room05', '5');

INSERT INTO t_stream(id, type, scope, protocol, host, port, create_at, room_id) VALUES
('1',  'DEVICE', 'ADMIN', 'srt', '113.31.109.140', 23012, '2019-12-23 15:03:31.024', '1'),
('2',  'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65102, '2019-12-23 15:03:31.024', '1'),
('3',  'DEVICE', 'USER',  'srt', '113.31.109.140', 23012, '2019-12-23 15:03:31.024', '1'),
('4',  'CAMERA', 'USER',  'srt', '106.75.216.96',  65102, '2019-12-23 15:03:31.024', '1'),
('5',  'DEVICE', 'ADMIN', 'srt', '106.75.216.96',  65103, '2019-12-23 15:03:31.024', '2'),
('6',  'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65104, '2019-12-23 15:03:31.024', '2'),
('7',  'DEVICE', 'USER',  'srt', '106.75.216.96',  65103, '2019-12-23 15:03:31.024', '2'),
('8',  'CAMERA', 'USER',  'srt', '106.75.216.96',  65104, '2019-12-23 15:03:31.024', '2'),
('9',  'DEVICE', 'ADMIN', 'srt', '106.75.216.96',  65105, '2019-12-23 15:03:31.024', '3'),
('10', 'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65106, '2019-12-23 15:03:31.024', '3'),
('11', 'DEVICE', 'USER',  'srt', '106.75.216.96',  65105, '2019-12-23 15:03:31.024', '3'),
('12', 'CAMERA', 'USER',  'srt', '106.75.216.96',  65106, '2019-12-23 15:03:31.024', '3'),
('13', 'DEVICE', 'ADMIN', 'srt', '106.75.216.96',  65107, '2019-12-23 15:03:31.024', '4'),
('14', 'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65108, '2019-12-23 15:03:31.024', '4'),
('15', 'DEVICE', 'USER',  'srt', '106.75.216.96',  65107, '2019-12-23 15:03:31.024', '4'),
('16', 'CAMERA', 'USER',  'srt', '106.75.216.96',  65108, '2019-12-23 15:03:31.024', '4'),
('17', 'DEVICE', 'ADMIN', 'srt', '106.75.216.96',  65109, '2019-12-23 15:03:31.024', '5'),
('18', 'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65110, '2019-12-23 15:03:31.024', '5'),
('19', 'DEVICE', 'USER',  'srt', '106.75.216.96',  65109, '2019-12-23 15:03:31.024', '5'),
('20', 'CAMERA', 'USER',  'srt', '106.75.216.96',  65110, '2019-12-23 15:03:31.024', '5');
