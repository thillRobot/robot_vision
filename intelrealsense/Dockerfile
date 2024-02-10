FROM ubuntu:focal

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt update && apt dist-upgrade -y && apt update && apt install -y apt-utils build-essential vim git wget curl apt-transport-https lsb-release

RUN mkdir -p /etc/apt/keyrings 
RUN curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | tee /etc/apt/keyrings/librealsense.pgp > /dev/null

RUN echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | \
tee /etc/apt/sources.list.d/librealsense.list && apt update

RUN apt update && \
DEBIAN_FRONTEND=noninteractive apt install -y librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg

ENV RS_WS=/home/realsense_ws
RUN mkdir -p $RS_WS/src 
#ENV CATKIN_WS=/home/catkin_ws
#RUN mkdir -p $CATKIN_WS/src 

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"] 
