# Running deepstream and viewing RTSP output stream 

## Step 1
- Go to AWS and launch a new instance
  - Amazon Machine Image
    -   A Community AMI
      - amazon/Deep Learning AMI GPU CUDA 11.2.1 (Ubuntu 20.04) 20220607
  - Instance type
      - g4dn.xlarge or g4dn.2xlarge (Both have NVIDIA T4 GPU * 1)
  - Remember to use a security group that has an inbound rule for SSH (default security group should work)

## Step 2
**Connect to the AWS instance you just launched**  
Check to ensure you can SSH to the instance you've created with:
`ssh ssh -i "valtec-dev-public-2.pem" ubuntu@ec2-3-236-54-47.compute-1.amazonaws.com`

**Connect to the instance inside VS Code**  
Doing so will allow us to navigate the remote machine from VS code like we do on our local machine.

**Remote Explorer setup and connecting**  
  - Launch Visual Studio Code and install the "Remote SSH" extension
  - Open "Remote Explorer" and configure an SSH remote (click the cog below)
  - <img width="1254" alt="image" src="https://github.com/neilvaltec/demo_deepstream/assets/1328795/6a638dd0-5144-4b44-888c-5cb9e23deffc">
  - Your .ssh.config file should be in this format:
    ```
    HostName ec2-3-236-54-47.compute-1.amazonaws.com # Public IPv4 DNS address of the instance
    User ubuntu
    IdentityFile ~/Downloads/valtec-dev-public-2.pem # Path to your private key file
    ```
  - After that you'll should see some remote hosts and users/session in explorer **which you can double check to connect**
    <img width="1170" alt="image" src="https://github.com/neilvaltec/demo_deepstream/assets/1328795/ceef04f7-976c-4666-b7f9-ecd777e06e17">

## Step 3
**Launching [drone_camera_rtsp_simulator](https://github.com/Valteq/drone_camera_rtsp_simulator)**  
  - SSH/Connect to the AWS instance
  - Find the latest tag [here](https://hub.docker.com/repository/docker/neilvaltec/drone_camera_rtsp_simulator/general)
  - Use it to run:
    ```
    docker run --network=host neilvaltec/drone_camera_rtsp_simulator:<tag>
    ```
  - Keep this container running
  - You can use the command `vlc rtsp://localhost:8666/drone_camera_1` to view the camera stream

## Step 4
**Launch [demo_deepstream](https://github.com/neilvaltec/demo_deepstream/tree/main)**  
  - Open another teriminal windows in VS Code and SSH/connect into the AWS instance
  - Find the latest tag for the deepstream container [here](https://hub.docker.com/repository/docker/neilvaltec/demo_deepstream/general)
  - Once connected, run this command:
    ```
    docker run --gpus all -it --rm --network=host neilvaltec/demo_deepstream:<tag> bash
    ```
  - After launching the container, you should be at `/opt/nvidia/deepstream/deepstream-6.2`.
  - cd to `samples/configs/deepstream-app/`
  - Do:
    ```
    deepstream-app -c demo_rtsp_in_rtsp_output.txt
    ```
  - Now the output of deepstream is streaming through `rtsp://localhost:8777/ds-test`
## Step 5  
**Access deepstream RTSP output stream from your local computer**  
VSCode with Remote Explorer will manage forwarded ports for you and should pick up when a remote container is forwarding a port to your local machine.

<img width="470" alt="image" src="https://github.com/neilvaltec/demo_deepstream/assets/1328795/8e79ef69-8a41-4f77-beb5-21bacf9edab7">

**In the event that doesn't work you can manually forward it with these commands...** 
  - Connect/SSH to the AWS deepstream instance
  - Configure SSH to forward the RTSP output from deepstream on remote port 8777 to local port 8777, do:
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

## Step 6 (optional)
**Access the output of the RSTP camera stream**  
Like deepstream above, Remote Explorer should handle port forwarding for you. But in case it doesn't here are instructions on how to manually do that.

- Connect/SSH to the deepstream AWS instance
- Configure SSH to forward the RTSP camera stream from remote port 8666 to local port 8666

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
