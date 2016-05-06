#!/bin/bash

docker run \
       --rm \
       --name=inner-weave \
       --net=host \
       -e DOCKER_HOST=tcp://127.0.0.1:2380 \
weave-exp:latest
