#!/bin/bash

set -e

export RS_WS=/home/realsense_ws

cd $RS_WS

exec "$@"
