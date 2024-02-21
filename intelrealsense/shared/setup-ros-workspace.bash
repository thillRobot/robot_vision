#!/bin/bash

export ROS=/opt/ros/noetic
source $ROS/setup.bash

# make a catkin_ws, this is overlayed on /opt/ros/noetic
export ROS_WS=/home/catkin_ws
mkdir -p $ROS_WS/src
cd $ROS_WS && catkin_make
source $ROS_WS/devel/setup.bash

# make a catkin_build_ws, this is also overlayed on /opt/ros/noetic
#apt-get -y update && apt install -y python3-catkin-tools
export ROB_WS=/home/catkin_build_ws
mkdir -p $ROB_WS/src
#cd $ROB_WS && catkin build
#source $ROB_WS/devel/setup.bash
# catkin_build_ws used to house teaserpp during build, not active ros workspace
