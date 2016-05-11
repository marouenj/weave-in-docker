#!/bin/bash

docker run -d \
       --privileged \
       --name=inner-docker \
       --net=host \
docker:1.11-dind \
docker daemon --host=tcp://127.0.0.1:2375 --storage-driver=vfs
