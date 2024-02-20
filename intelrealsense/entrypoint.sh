#!/bin/bash

set -e

export RS_WS=/home/realsense_ws
export ROS=/opt/ros/noetic
export ROS_WS=/home/catkin_ws
export ROL_WS=/home/overlay_ws

echo "source $ROS/setup.bash" >> /root/.bashrc
echo "cd $ROS_WS && catkin_make && source $ROS_WS/devel/setup.bash" >> /root/.bashrc
echo "cd $ROL_WS && source $ROS_WS/devel/setup.bash && catkin_make" >> /root/.bashrc

#echo "source $ROS/setup.bash" >> /root/.bashrc
#echo "source $ROL_WS/devel/setup.bash" >> /root/.bashrc

exec "$@"
