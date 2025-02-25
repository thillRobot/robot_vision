#!/bin/bash

export ROB_WS=/home/catkin_build_ws

# download and install teaserpp from source
apt install libeigen3-dev libboost-all-dev
git clone https://github.com/MIT-SPARK/TEASER-plusplus.git $ROB_WS/src/TEASER-plusplus
cd $ROB_WS/src/TEASER-plusplus && mkdir build && cd build && \
cmake -DBUILD_TEASER_FPFH=ON .. && \
make && \
make install && \
ldconfig
cd $ROB_WS/src/TEASER-plusplus/examples/teaser_cpp_ply && mkdir build && cd build && \
cmake .. && make

