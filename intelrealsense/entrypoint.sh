#!/bin/bash

set -e

#export RS_WS=/home/realsense_ws

export ROS=/opt/ros/noetic
#source $ROS/setup.bash

export ROS_WS=/home/catkin_ws
export ROL_WS=/home/overlay_ws
#cd $ROL_WS && source $ROS_WS/devel/setup.bash && catkin_make


#cd $ROS_WS/src/seam_detection && git pull # this wont work without keys...
#cd $ROS_WS && catkin_make
#cp /home/shared/launch/. -r $ROS_WS/src/realsense-ros/realsense2_camera/launch/ 
#cp /home/shared/rviz/. -r $ROS_WS/src/realsense-ros/realsense2_camera/rviz/ 


#echo "source $ROS/setup.bash" >> /root/.bashrc
#echo "source $ROS_WS/devel/setup.bash" >> /root/.bashrc
#echo "source $ROL_WS/devel/setup.bash" >> /root/.bashrc

exec "$@"
