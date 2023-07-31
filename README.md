# demo_deepstream
This repo demos the frameowork, Deepstream, that it will consume a video or a RTSP and do the object detection, then output the result as a RTSP.
## Prebuilt image
- [HERE](https://hub.docker.com/repository/docker/neilvaltec/demo_deepstream)
## Build the image
- Follow https://stackoverflow.com/a/61737404 first
- When it builds, it will automatically run a demo that consumes a video and store the output RTSP as videos with two different methods.
  - binary: executed by a compiled binary execution app with a config file.
  - python: executed by a python script.
- Run
  ```bash
  docker build -t neilvaltec/demo_deepstream:tag .
  ```
- Check the dockerfile for more details.
## Run the contianer 
```bash
docker run -it --rm --gpus all neilvaltec/demo_deepstream:tag bash
```
## Notes
- col: method
- row: input source

  ||video|RTSP|
  |---|---|---|
  |deepstream-app|V|V|
  |python script|V|TODO|


## Environments
- Cloud provider
    - AWS
- Image
    - amazon/Deep Learning AMI GPU CUDA 11.2.1 (Ubuntu 20.04) 20220607
- Instance type
    - g4dn.2xlarge (NVIDIA T4 GPU * 1)
