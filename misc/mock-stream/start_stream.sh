#!/bin/bash
set -e

#for i in `seq 17`; do
#    ffmpeg -i "./video`printf '%02d' $i`.mp4" -vcodec mpeg4 -acodec aac -f mpegts "./video`printf '%02d' $i`.ts"
#done

python mock_stream.py 65101 video01.ts
python mock_stream.py 65102 video02.ts
python mock_stream.py 65103 video03.ts
python mock_stream.py 65104 video04.ts
python mock_stream.py 65105 video05.ts
python mock_stream.py 65106 video06.ts
python mock_stream.py 65107 video07.ts
python mock_stream.py 65113 video07.ts --title dual
python mock_stream.py 65108 video08.ts
python mock_stream.py 65109 video09.ts
python mock_stream.py 65110 video10.ts
python mock_stream.py 65111 video11.ts
python mock_stream.py 65112 video12.ts
