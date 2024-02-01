FROM ubuntu:focal

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt update && apt dist-upgrade -y && apt update && apt install -y apt-utils build-essential vim git wget curl
RUN apt install -y apt-transport-https lsb-release

RUN DEBIAN_FRONTEND=noninteractive apt install -y libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev cmake \ 
    libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at libudev-dev

RUN git clone https://github.com/IntelRealSense/librealsense
RUN cd librealsense && ./scripts/patch-realsense-ubuntu-lts-hwe.sh

RUN echo 'hid_sensor_custom' | tee -a /etc/modules


ENV RS_WS=/home/realsense_ws
RUN mkdir -p $RS_WS/src 

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"] 
