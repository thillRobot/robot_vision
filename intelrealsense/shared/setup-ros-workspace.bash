#!/bin/bash

export ROS=/opt/ros/noetic
source $ROS/setup.bash

# make a catkin workspace, this is overlayed on /opt/ros/noetic
export ROS_WS=/home/catkin_ws
mkdir -p $ROS_WS/src
cd $ROS_WS/ && catkin_make
source $ROS_WS/devel/setup.bash

