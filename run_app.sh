#!/bin/sh

cd samples/configs/deepstream-app/
deepstream-app -c demo_rtsp_output.txt &

sleep 1

ffmpeg -i rtsp://localhost:8554/ds-test -c copy /root/output/output_app.mp4

cd ../../../

