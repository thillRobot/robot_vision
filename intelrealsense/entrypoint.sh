#!/bin/bash

set -e

export RS_WS=/home/realsense_ws

export ROS=/opt/ros/noetic
echo "source $ROS/setup.bash" >> /root/.bashrc

# /home/catkin_ws overlays opt/ros/noetic
export ROS_WS=/home/catkin_ws
echo "cd $ROS_WS && catkin_make && source $ROS_WS/devel/setup.bash" >> /root/.bashrc

# /home/overlay_ws overlays /home/catkin_ws
export ROL_WS=/home/overlay_ws
echo "cd $ROL_WS && catkin_make && source $ROL_WS/devel/setup.bash" >> /root/.bashrc

# /home/catkin_build_ws overlays /home/catkin_ws # catkin build not currently used
#export ROB_WS=/home/catkin_build_ws
#echo "cd $ROB_WS && catkin build && source $ROB_WS/devel/setup.bash" >> /root/.bashrc

#echo "export ROS_IP=192.168.200.210" >> /root/.bashrc
#echo "export ROS_MASTER_URI=http://192.168.200.199:11311" >> /root/.bashrc

exec "$@"
