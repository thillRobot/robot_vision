# intelrealsense

## simple guide to using Intel realsense camera in docker

## list of sensors

- Intel Realsense d435i - RGBD Camera - tested
- Intel Realsense d455  - RGBD Camera - tested

## Docker + docker compose

The Dockerfile is built from `ubuntu:focal` and follows the `distribution_linux` installation instructions [here](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md)

Set the home directory for the container to this directory 
```
export RS_WS_PATH=$PWD
```

allow access to graphics
```
xhost local:root
```

bring up the project and build the image, this will also start the realsense-viewer 
```
docker compose up --build --remove-orphans
```

after the image is built it can be run as a service from the `docker-compose.yaml` file
```
docker compose run realsense-viewer
```

close when you done, if you want to ;)
```
docker compose down
```









