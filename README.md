# demo_deepstream
This repo demos the frameowork, Deepstream, that it will consume a video or a RTSP and do the object detection, then output the result as a RTSP.

Because everything is running on AWS, forwarding screen will be too annoying. Here we use ffmpeg to record the RTSP stream. Check dockerfile for more details.

## How to get a deepstream RTSP output in your local computer
- See [instructions](https://github.com/neilvaltec/demo_deepstream/blob/main/instructions.md)

## Prebuilt image
- [HERE](https://hub.docker.com/repository/docker/neilvaltec/demo_deepstream)

## Detailed Demo video
- [Here](https://drive.google.com/file/d/1jrcJYUSG_GSZPGFznRXavHkDJIOnPqPx/view?usp=sharing)

## The diagram in the demo video
<img width="1266" alt="Screenshot 2023-08-03 at 4 21 54 AM" src="https://github.com/neilvaltec/demo_deepstream/assets/133841195/c7387564-046b-4b4c-826a-346e498b9fe5">

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
- You can check the deepstream output result during the image build under `/root/output/`

## Run the contianer 
- Check [here](https://github.com/Valteq/starship/issues/6#issuecomment-1635487547) to see how to run a container as a input RTSP. 
- ```bash
  docker run -it --rm --gpus all --network:container:<container_id> neilvaltec/demo_deepstream:tag bash
  ```
## Notes
- col: method
- row: input source

  ||video|RTSP|
  |---|---|---|
  |deepstream-app|V|V|
  |python script|V|TODO|