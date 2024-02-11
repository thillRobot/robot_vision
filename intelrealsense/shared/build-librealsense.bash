#!/bin/bash

export RS_WS=/home/realsense_ws

echo 'hid_sensor_custom' | tee -a /etc/modules 
  
cd $RS_WS/librealsense && mkdir build && cd build && cmake ../ -DBUILD_EXAMPLES=true &&\
    make uninstall && make clean && make -j8 && make install

