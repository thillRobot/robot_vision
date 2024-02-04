FROM ubuntu:focal

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt update && apt upgrade -y 
RUN apt update && apt install -y apt-utils build-essential vim git wget curl apt-transport-https

RUN DEBIAN_FRONTEND=noninteractive apt install -y libssl-dev libusb-1.0-0-dev libudev-dev \  
    pkg-config libgtk-3-dev cmake libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at libudev-dev udev \ 
    libelf-dev elfutils dwarves bison flex lsb-release

# build librealsense from source
ENV RS_WS=/home/realsense_ws
RUN mkdir $RS_WS 

RUN cd $RS_WS && git clone https://github.com/IntelRealSense/librealsense
#use sed to remove the 'sudo' prefix from the commmands in the scripts
RUN cd $RS_WS/librealsense && sed -i 's/sudo//g' scripts/setup_udev_rules.sh
RUN cd $RS_WS/librealsense && sed -i 's/sudo//g' scripts/patch-utils-hwe.sh
RUN cd $RS_WS/librealsense && sed -i 's/sudo//g' scripts/patch-realsense-ubuntu-lts.sh

RUN cd $RS_WS/librealsense && ./scripts/setup_udev_rules.sh

# run this line manually from bash in container instead, or just skip it, who needs the patch anyway
# RUN DEBIAN_FRONTEND=noninteractive cd $RS_WS/librealsense && ./scripts/patch-realsense-ubuntu-lts-hwe.sh

RUN echo 'hid_sensor_custom' | tee -a /etc/modules

RUN cd $RS_WS/librealsense && mkdir build && cd build && cmake ../ -DBUILD_EXAMPLES=true &&\
    make uninstall && make clean && make -j8 && make install

SHELL ["/bin/bash", "-c"] 
# install ROS Noetic from repository
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y ros-noetic-desktop-full python3-rosdep
RUN source /opt/ros/noetic/setup.bash
RUN rosdep init && rosdep update

# setup and build catkin workspace
ENV ROS_WS=/home/catkin_ws
ENV ROS=/opt/ros/noetic
RUN source $ROS/setup.bash && mkdir -p $ROS_WS/src 
# && cd $ROS_WS && catkin_make # completed below by intel, thanks alot guys...

RUN apt update && apt install -y ros-noetic-ddynamic-reconfigure
# install realsense ROS from source
RUN source $ROS/setup.bash && cd $ROS_WS/src && git clone https://github.com/IntelRealSense/realsense-ros.git && cd realsense-ros/ && \
    git checkout `git tag | sort -V | grep -P "^2.\d+\.\d+" | tail -1` && cd .. && \
    catkin_init_workspace && cd .. && \
    catkin_make clean && catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release && catkin_make install
RUN source $ROS/setup.bash

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"] 
