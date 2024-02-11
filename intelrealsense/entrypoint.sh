#!/bin/bash

set -e

#export RS_WS=/home/realsense_ws

export ROS=/opt/ros/noetic
export ROS_WS=/home/catkin_ws
source $ROS/setup.bash

echo "source $ROS/setup.bash" >> /root/.bashrc
echo "source $ROS_WS/devel/setup.bash" >> /root/.bashrc

#cd $ROS_WS/src/seam_detection && git pull # this wont work without keys...
cd $ROS_WS && catkin_make
cd /home

exec "$@"
