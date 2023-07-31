#!/bin/sh
set -e

cd sources/deepstream_python_apps/apps/deepstream-test1-rtsp-out
python3 deepstream_test1_rtsp_out.py -i ../../../../samples/streams/sample_720p.h264 &

sleep 1

ffmpeg -i rtsp://localhost:8554/ds-test -c copy /root/output/output_python.mp4

cd ../../../../
