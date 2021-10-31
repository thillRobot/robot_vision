# lx_vision
  This is a ROS package for camera and computer vison for the Pioneer LX Robot at Tennessee Technological University 

## Updating to Ubuntu 20.04 and ROS Noetic 

### Overview

The LX robot at Tennessee Tech ran in Ubuntu Mate 16.04 for a long time. In the summer of 2021, the embedded Intel Atom computer was updated to Ubuntu Mate 20.04. An Intel NUC (thanks RTT) is now used as the control computer and development environment. 

The robot is intended to be used for guest demos and testing for the tour guide/greeter robot. Currently the SICK LiDAR is the primary sensor used for obstacle detection and navigation. In addition to LiDAR, the LX robot needs vison to increase safety and effectiveness during human interaction. 

### Goals
- [] enable Kinect V1 currently mounted and wired to LX robot
- [] enable rtabmap algorithms from Kinetic (archived launch files)
- [] add addtional two more kinects to increase fieid of view
- [] enable ZED stereo camera
- [] enable human detection, skeleton detecton, gesture detection

### Approach

There are serveral ways to approach this. To begin, I want to test the rtabmap algoritms that were used with the LX in Kinetic. The launch files from Kinetic are archived in this repository so this should work!

**Single Computer Approach:** Cameras directly on LX embedded computer (Intel Atom dual core 64bit)
	I  predict there will be resource limitations due to the age of the computer.

**Distributed Approach:** Cameras on separate camera module computer on-board robot.

- Camera Module Option 1: Intel i3/i5 - Lenovo M73 TinyDesktop 
- Camera Module Option 2: Nvidia Jetson Nano 2Gb/4Gb or TX2 NX (4Gb)
- Camera Module Option 3: Raspberry Pi 3b 
	
### Camera Selection

- Kinect V1 
- ZED Stereo
- Webcams
- I should buy a gigevision camera

### Enabling the Kinect V1

Kinect V1 + Jetson Nano jetpack 4.6 upgraded to 20.04 = currently not working in 20.04 (dont give up!)

Kinect V1 + i5 thinkpad ubuntu 20.04  = currently working in 20.04 (it works super cool!)

Follow this [guide](https://aibegins.net/2020/11/22/give-your-next-robot-3d-vision-kinect-v1-with-ros-noetic/) and it works great. 

### Enabling the ZED stereo camera 

ZED stereo (v1 I guess) on the Jetson Nano 4GB BO1 (2019) (model:P3450)

This approach is desired because the jetson is so low power and the M73 i5 is not. The robot has a huge battery, so this is not the biggest deal. The M73 has outdated embedded intel graphics, so the Jetsons Maxwell GPU should do much better with the camera stream.

If this works, it should port over to the TX2 NX if the nano has resource issues. It is below the reccomended specs from stereo labs, but we are going to try anyway. I have a feeling that it will work because I do not even want to display the video there or perform complex analyis...time to test

Here is what I have done. 

#### Step 1 - Setup Jetson Nano
Follow the getting started turtorial from Nvidia [here](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit).
This involves downloading the operating system image from [here](https://developer.nvidia.com/jetson-nano-sd-card-image) and flashing it with the program of your choice. I have used pi-imager and balena-etcher, but I want to try `dd`. I tried once, but it did not work and now I now why. It is time to try again with `dd` 







## old stuff below here 

Goal: DO STUFF with RTABMAP and LX

    THis should work with a single launch file! MAKE THAT HAPPEN!:

    ON THE ROBOT COMPUTER (the kinect is plugged into the external usb port on LX)

        thill@robot:~$ roslaunch ttu_camera lx_3dmap.launch

	thill@robotlab-t1600:~$ roslaunch rtabmap_ros rtabmap.launch rgb_topic:=/camera/data_throttled_image depth_topic:=/camera/data_throttled_image_depth camera_info_topic:=/camera/data_throttled_camera_info compressed:=true rtabmap_args:="--delete_db_on_start"


	Now you should see the mapping in the rtabmapviz window! Woop Woop!
	Close the terminals and then do this.

	    thill@robotlab-t1600:~$ rtabmap-databaseViewer ~/.ros/rtabmap.db

	You can now save the file as a .ply and open it with 'meshlab'

  This works but my launch files should work!
