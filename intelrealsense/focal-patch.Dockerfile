FROM ubuntu:focal

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get update && apt-get upgrade -y 
RUN apt-get update && apt-get install -y apt-utils build-essential vim git curl 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev libusb-1.0-0-dev libudev-dev udev\  
    pkg-config libgtk-3-dev cmake libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at\ 
    libelf-dev elfutils dwarves bison flex lsb-release apt-transport-https dialog

# get librealsense source
ENV RS_WS=/home/realsense_ws
RUN mkdir $RS_WS 
RUN cd $RS_WS && git clone https://github.com/IntelRealSense/librealsense
# use sed to remove the 'sudo' prefix from the commmands in the udev script
RUN cd $RS_WS/librealsense && sed -i 's/sudo//g' scripts/setup_udev_rules.sh
RUN cd $RS_WS/librealsense && ./scripts/setup_udev_rules.sh

# apply kernel patch from librealsense 
RUN cd $RS_WS/librealsense && sed -i 's/sudo//g' scripts/patch-utils-hwe.sh
RUN cd $RS_WS/librealsense && sed -i 's/sudo//g' scripts/patch-realsense-ubuntu-lts-hwe.sh
# run this line manually from bash in container instead, or just skip it, who needs the patch anyway
#RUN DEBIAN_FRONTEND=dialog cd $RS_WS/librealsense && ./scripts/patch-realsense-ubuntu-lts-hwe.sh
#SHELL ["/bin/bash", "-c"]
#RUN DEBIAN_FRONTEND=dialog cd $RS_WS/librealsense && ./scripts/patch-realsense-ubuntu-lts-hwe.sh<<<$'n\n y\n n\n y\n n\n y\n'
#
#	# build and install librealsense
#	COPY ./shared/build-librealsense.bash /
#	RUN ./build-librealsense.bash
#
#	# install ROS Noetic from repository
#	ENV ROS=/opt/ros/noetic
#	COPY ./shared/install-ros-noetic.bash /
#	RUN ./install-ros-noetic.bash
#
#	# setup ros workspace
#	ENV ROS_WS=/home/catkin_ws
#	COPY ./shared/setup-ros-workspace.bash /
#	RUN ./setup-ros-workspace.bash
#
#	# ds455 works as usb3.2 in realsense-viewer up to this point
#	# install realsense-ros from sourcee
#	COPY ./shared/install-realsense-ros.bash /
#	RUN ./install-realsense-ros.bash
#
#	# install teaserpp if needed, uncomment in CMakelists if not
#	COPY ./shared/install-teaserpp.bash
#	RUN ./install-teaserpp.bash

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"] 
