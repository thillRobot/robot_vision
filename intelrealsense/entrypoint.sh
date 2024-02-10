#!/bin/bash

set -e

export RS_WS=/home/realsense_ws
export ROS_WS=/home/catkin_ws

source /opt/ros/noetic/setup.bash
source $ROS_WS/devel/setup.bash

#cd $RS_WS
#cd $CATKIN_WS

cd /home

exec "$@"
