# Instructions for how to get a deepstream RTSP output in your local computer

## Step 1
- Go to AWS and launch an instance
  - Image
      - amazon/Deep Learning AMI GPU CUDA 11.2.1 (Ubuntu 20.04) 20220607
  - Instance type
      - g4dn.xlarge or g4dn.2xlarge (Both have NVIDIA T4 GPU * 1)
  - Remember to enable SSH access

## Step 2
- Launch [drone_camera_rtsp_simulator](https://github.com/Valteq/drone_camera_rtsp_simulator)
  - Get into the AWS instance and do
    ```
    docker run --network=host neilvaltec/drone_camera_rtsp_simulator:<tag>
    ```
  - Check the latest tag at [here](https://hub.docker.com/repository/docker/neilvaltec/drone_camera_rtsp_simulator/general)
  - Keep this container running
  - The camera simulator RTSP url is `rtsp://localhost:8666/drone_camera_1`

## Step 3
- Launch [demo_deepstream](https://github.com/neilvaltec/demo_deepstream/tree/main)
  - Get into the AWS instance, open another terminal, then do
    ```
    docker run -it --rm --network=host neilvaltec/demo_deepstream:<tag> bash
    ```
  - Check the latest tag at [here](https://hub.docker.com/repository/docker/neilvaltec/demo_deepstream/general)
  - After launching the container, you should be at `/opt/nvidia/deepstream/deepstream-6.2`.
  - cd to `samples/configs/deepstream-app/`
  - Do
    ```
    deepstream-app -c demo_rtsp_in_rtsp_output.txt
    ```
  - Now the output of deepstream is streaming through `rtsp://localhost:8777/ds-test`
## Step 4
- Check if you can access the output of deepstream in your local computer
  - To connect to the AWS instance and receive the RTSP output from Deepstream (port 8777), do
    ```
    ssh -i <your_security_key> -N -L 8777:<the_public_DNS>:8777 ubuntu@<the_public_DNS>
    ```
  - e.g. 
    ```
    ssh -i valtec-dev-public.pem -N -L 8777:ec2-54-197-38-251.compute-1.amazonaws.com:8777 ubuntu@ec2-54-197-38-251.compute-1.amazonaws.com
    ```
  - You can use VLC to inspect if the RTSP works. Do
    ```
    vlc rtsp://localhost:8777/ds-test
    ```
    Sometimes you'll need to wait more than 30 seconds for the frame to show up.

## Step 5 (optional)
- Check if you can access the output of the drone camera simulator in your local computer
  - To connect to the AWS instance and receive the RTSP output from Deepstream (port 8777), do
    ```
    ssh -i <your_security_key> -N -L 8666:<the_public_DNS>:8666 ubuntu@<the_public_DNS>
    ```
  - e.g. 
    ```
    ssh -i valtec-dev-public.pem -N -L 8666:ec2-54-197-38-251.compute-1.amazonaws.com:8666 ubuntu@ec2-54-197-38-251.compute-1.amazonaws.com
    ```
  - You can use VLC to inspect if the RTSP works. Do
    ```
    vlc rtsp://localhost:8666/drone_camera_1
    ```
    Sometimes you'll need to wait more than 30 seconds for the frame to show up.

## Notes
- There is a [demo video](https://github.com/neilvaltec/demo_deepstream/tree/main#detailed-demo-video) that illustrates details of the above steps.