#!/bin/bash

docker run -d \
       --privileged \
       --name=inner-docker \
       --net=host \
docker:dind \
docker daemon --host=unix:///var/run/docker.sock --host=tcp://127.0.0.1:2380 --storage-driver=vfs
