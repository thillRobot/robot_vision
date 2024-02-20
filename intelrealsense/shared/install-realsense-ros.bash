#!/bin/bash

export ROS=/opt/ros/noetic
source $ROS/setup.bash

export ROS_WS=/home/catkin_ws

#install realsense-ros dependencies
apt update && apt install -y ros-noetic-ddynamic-reconfigure

#install realsense ROS from source
cd $ROS_WS/src && git clone https://github.com/IntelRealSense/realsense-ros.git && cd realsense-ros/ && \
git checkout `git tag | sort -V | grep -P "^2.\d+\.\d+" | tail -1` && cd .. && \
#catkin_init_workspace && cd .. && \
cd .. && \
catkin_make clean && catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release && catkin_make install
source $ROS_WS/devel/setup.bash

# install realsense2-description for camera models and launch files...check first in case in comes with the build

