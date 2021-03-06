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

INSERT INTO t_stream(id, type, scope, protocol, host, port, path, create_at, room_id) VALUES
('1',  'DEVICE', 'ADMIN', 'srt', '113.31.109.140', 23012, '', '2019-12-23 15:03:31.024', '1'),
('2',  'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65102, '', '2019-12-23 15:03:31.024', '1'),
('3',  'DEVICE', 'USER',  'srt', '113.31.109.140', 23012, '', '2019-12-23 15:03:31.024', '1'),
('4',  'CAMERA', 'USER',  'srt', '106.75.216.96',  65102, '', '2019-12-23 15:03:31.024', '1'),
('5',  'CAMERA', 'QC',    'srt', '106.75.216.96',  65201, '', '2019-12-23 15:03:31.024', '1'),
('6',  'DEVICE', 'ADMIN', 'srt', '106.75.216.96',  65103, '', '2019-12-23 15:03:31.024', '2'),
('7',  'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65104, '', '2019-12-23 15:03:31.024', '2'),
('8',  'DEVICE', 'USER',  'srt', '106.75.216.96',  65103, '', '2019-12-23 15:03:31.024', '2'),
('9',  'CAMERA', 'USER',  'srt', '106.75.216.96',  65104, '', '2019-12-23 15:03:31.024', '2'),
('10', 'CAMERA', 'QC',    'srt', '106.75.216.96',  65202, '', '2019-12-23 15:03:31.024', '2'),
('11', 'DEVICE', 'ADMIN', 'srt', '106.75.216.96',  65105, '', '2019-12-23 15:03:31.024', '3'),
('12', 'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65106, '', '2019-12-23 15:03:31.024', '3'),
('13', 'DEVICE', 'USER',  'srt', '106.75.216.96',  65105, '', '2019-12-23 15:03:31.024', '3'),
('14', 'CAMERA', 'USER',  'srt', '106.75.216.96',  65106, '', '2019-12-23 15:03:31.024', '3'),
('15', 'CAMERA', 'QC',    'srt', '106.75.216.96',  65203, '', '2019-12-23 15:03:31.024', '3'),
('16', 'DEVICE', 'ADMIN', 'srt', '106.75.216.96',  65107, '', '2019-12-23 15:03:31.024', '4'),
('17', 'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65108, '', '2019-12-23 15:03:31.024', '4'),
('18', 'DEVICE', 'USER',  'srt', '106.75.216.96',  65107, '', '2019-12-23 15:03:31.024', '4'),
('19', 'CAMERA', 'USER',  'srt', '106.75.216.96',  65108, '', '2019-12-23 15:03:31.024', '4'),
('20', 'CAMERA', 'QC',    'srt', '106.75.216.96',  65204, '', '2019-12-23 15:03:31.024', '4'),
('21', 'DEVICE', 'ADMIN', 'srt', '106.75.216.96',  65109, '', '2019-12-23 15:03:31.024', '5'),
('22', 'CAMERA', 'ADMIN', 'srt', '106.75.216.96',  65110, '', '2019-12-23 15:03:31.024', '5'),
('23', 'DEVICE', 'USER',  'srt', '106.75.216.96',  65109, '', '2019-12-23 15:03:31.024', '5'),
('24', 'CAMERA', 'USER',  'srt', '106.75.216.96',  65110, '', '2019-12-23 15:03:31.024', '5'),
('25', 'CAMERA', 'QC',    'srt', '106.75.216.96',  65205, '', '2019-12-23 15:03:31.024', '5');
