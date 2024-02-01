# intelrealsense

## simple guide to using Intel realsense camera in docker

## list of sensors

- Intel Realsense d435i - RGBD Camera - tested
- Intel Realsense d455  - RGBD Camera - tested

## Docker + docker compose

The Dockerfile is based on the `distribution_linux` installation instructions [here](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md)

Set the home directory for the container to this directory 
```
export RS_WS_PATH=$PWD
```

allow access to graphics
```
xhost local:root
```

start and build the project 
```
docker compose up --build --remove-orphans
```

run a service from the `docker-compose.yaml` file
```
docker compose run realsense
```










