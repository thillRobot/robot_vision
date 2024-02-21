#!/bin/bash

# install ROS Noetic from repository
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y ros-noetic-desktop-full python3-rosdep
source /opt/ros/noetic/setup.bash
rosdep init && rosdep update

#setup and build catkin workspace, moved to setup-ros-workspace.bash
#export ROS_WS=/home/catkin_ws
#export ROS=/opt/ros/noetic
#source $ROS/setup.bash && mkdir -p $ROS_WS/src
#cd $ROS_WS && catkin_make 

apt-get update && apt-get install -y python3-catkin-tools
