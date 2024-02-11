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
cp /home/shared/launch/. -r $ROS_WS/src/realsense-ros/realsense2_camera/launch/ 
cp /home/shared/rviz/. -r $ROS_WS/src/realsense-ros/realsense2_camera/rviz/ 

exec "$@"
