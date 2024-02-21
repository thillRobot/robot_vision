FROM intelrealsense-realsense-build:focal-patch

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get update && apt-get upgrade -y 
RUN apt-get update && apt-get install -y apt-utils build-essential vim git curl 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev libusb-1.0-0-dev libudev-dev udev\  
    pkg-config libgtk-3-dev cmake libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at\ 
    libelf-dev elfutils dwarves bison flex lsb-release apt-transport-https dialog

# note, kernel patch from intel has been applied to image

# build and install librealsense
COPY ./shared/build-librealsense.bash /
RUN ./build-librealsense.bash

# install ROS Noetic from repository
ENV ROS=/opt/ros/noetic
COPY ./shared/install-ros-noetic.bash /
RUN ./install-ros-noetic.bash

# setup ros workspace
ENV ROS_WS=/home/catkin_ws
COPY ./shared/setup-ros-workspace.bash /
RUN ./setup-ros-workspace.bash

# install realsense-ros from sourcee
COPY ./shared/install-realsense-ros.bash /
RUN ./install-realsense-ros.bash

#RUN apt-get update
# install teaserpp if needed, uncomment in CMakelists if not
COPY ./shared/install-teaserpp.bash /
RUN ./install-teaserpp.bash

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"] 
