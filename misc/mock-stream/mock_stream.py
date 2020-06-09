# -*- coding: utf-8 -*-

import argparse
import logging
import os
import socket
import sys


LOGGER = logging.getLogger('ROOT')


def get_free_port():
    udp = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    udp.bind(('', 0))
    addr, port = udp.getsockname()
    udp.close()
    return port


def parse_args():
    """parse_args parses command line arguments."""
    parser = argparse.ArgumentParser('mock_stream.py')

    parser.add_argument('port', type=int, help='local SRT port')
    parser.add_argument('video_file', type=str, help='local video file path')

    parser.add_argument('--video_path', type=str, default='/home/dantin/Downloads/video', help='local video directory path')
    parser.add_argument('--title', type=str, default='', help='tmux window title')

    parser.add_argument('-L', '--level', choices=('debug', 'info', 'warn'), default='info', help='log level: debug, info, warn')
    parser.add_argument('-V', '--version', help='print version information', action='store_true')

    args = parser.parse_args()

    if args.version:
        print('mock stream, version', '0.1-dev')
        sys.exit(0)

    return args


def init():
    """init do initialization."""
    args = parse_args()

    # setup logging.
    default_handler = logging.StreamHandler()
    default_handler.setFormatter(logging.Formatter(
        '[%(asctime)s] %(levelname)s: %(message)s'))
    LOGGER.addHandler(default_handler)
    if args.level == 'info':
        LOGGER.setLevel(logging.INFO)
    elif args.level == 'warn':
        LOGGER.setLevel(logging.WARN)
    else:
        LOGGER.setLevel(logging.DEBUG)

    return args


def open_video_stream(video_path, port, title, tmp_port):
    LOGGER.info('open video stream using file "%s"', video_path)
    current_dir = os.getcwd()
    ffmpeg_cmd = '''ffmpeg -stream_loop -1 -re -i {video_path} -codec copy -f mpegts "udp://127.0.0.1:{port}?pkt_size=1316"'''
    srt_cmd = '''srt-live-transmit "udp://127.0.0.1:{src_port}" "srt://:{dest_port}" -v'''

    LOGGER.info('execute processes using tmux window, title "%s"', title)
    LOGGER.info('generate video stream on port %d', tmp_port)
    new_process_cmd = 'tmux new-window -n "{title}" -c "{working_dir}" {cmd}'
    os.system(new_process_cmd.format(title=title, working_dir=current_dir, cmd=ffmpeg_cmd.format(video_path=video_path, port=tmp_port)))

    LOGGER.info('open port %d for SRT of video stream %s', port, title)
    sub_process_cmd = 'tmux split-window -v -c "{working_dir}" -t "{title}" {cmd}'
    os.system(sub_process_cmd.format(working_dir=current_dir, title=title, cmd=srt_cmd.format(src_port=tmp_port, dest_port=port)))


def main():
    args = init()
    video_file, port = args.video_file, args.port
    if os.path.exists(args.video_path):
        video_file = os.path.join(args.video_path, args.video_file)

    if not os.path.exists(video_file):
        LOGGER.warn('video file "%s" not found', video_file)

    title = args.title
    if not title:
        title = os.path.basename(video_file)
        title, _ = os.path.splitext(title)
    tmp_port = get_free_port()
    LOGGER.info('find free udp port %d', tmp_port)

    open_video_stream(video_file, port, title, tmp_port)
    LOGGER.info('done!')


if __name__ == '__main__':
    main()
