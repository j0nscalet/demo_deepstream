FROM nvcr.io/nvidia/deepstream:6.2-samples

COPY . .

# check GPU availablity 
RUN nvidia-smi

# install 
RUN ./install.sh
RUN ./user_additional_install.sh
RUN apt update && apt install -y vim wget ffmpeg python3-pip
RUN wget https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/releases/download/v1.1.6/user_deepstream_python_apps_install.sh
RUN bash user_deepstream_python_apps_install.sh -v 1.1.6
# RUN wget https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/releases/download/v1.1.6/pyds-1.1.6-py3-none-linux_x86_64.whl
# RUN python3 -m pip install pyds-1.1.6-py3-none-linux_x86_64.whl
WORKDIR /opt/nvidia/deepstream/deepstream-6.2/sources/deepstream_python_apps
RUN git checkout v1.1.6
WORKDIR /opt/nvidia/deepstream/deepstream-6.2/sources/deepstream_python_apps/apps/deepstream-test1-rtsp-out
RUN apt-get install -y libgstrtspserver-1.0-0 gstreamer1.0-rtsp libgirepository1.0-dev gobject-introspection gir1.2-gst-rtsp-server-1.0
RUN mkdir /root/output

WORKDIR /opt/nvidia/deepstream/deepstream-6.2

# python method
# run the demo of python method, should be able to see the result file `/root/output/output_python` after finish
RUN sh run_python.sh

# binary method
# run the demo of binary method, should be able to see the result file `/root/output/output_app` after finish
RUN cp demo_rtsp_output.txt /opt/nvidia/deepstream/deepstream-6.2/samples/configs/deepstream-app/
RUN sh run_app.sh




