#!/bin/bash

docker run -d \
       --privileged \
       --name=inner-docker \
       -p 2380:2375 \
docker:dind 
