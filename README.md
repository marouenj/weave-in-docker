# weave-in-docker
A PoC for running Weave as a system-docker container in RancherOS

# Env
Ubuntu running a Docker daemon.
```ruby
Vagrant.configure("2") do ...
        machine.vm.box = "ubuntu/trusty64"
        machine.vm.provision "docker", images: ["docker:1.11", "docker:1.11-dind"]
        ...
end
```

# Start a nested docker daemon
```bash
> cd /vagrant/

> cat run/docker.sh 
#!/bin/bash

docker run -d \
       --privileged \
       --name=inner-docker \
       --net=host \
docker:1.11-dind \
docker daemon --host=unix:///var/run/docker.sock --host=tcp://127.0.0.1:2375 --storage-driver=vfs

> ./run/docker.sh
```

# Package Weave in a Docker image
```bash
cd /vagrant/Dockerfiles/

ls
build.sh  Dockerfile  dwnld.sh  weave

./build.sh

docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
weave-exp           latest              ...                 ...                 ...
```

# Run containerized Weave
```bash
cd /vagrant/

cat run/weave_launch.sh 
#!/bin/bash

docker run \
       --rm \
       --name=inner-weave \
       --net=host \
       -e DOCKER_HOST=tcp://127.0.0.1:2375 \
weave-exp:latest

./run/weave_launch.sh
```

# Point future docker launches to Weave proxy
```bash
eval $(./run/weave_env.sh)
```

# Launch a simple server
```bash
docker run -d \
       --name=pingme \
       gliderlabs/alpine \
nc -p 4000 -ll -e echo 'Hello, Weave!'
```

# Launch a simple client
docker run -it \
       --name=pinger \
       gliderlabs/alpine \
sh -l

# inside pinger
```bash
> ping -c3 pingme.weave.local
64 bytes from 10.32.0.1: seq=0 ttl=64 time=0.096 ms
64 bytes from 10.32.0.1: seq=1 ttl=64 time=0.093 ms
64 bytes from 10.32.0.1: seq=2 ttl=64 time=0.071 ms
...

> echo "What's up?" | nc pingme.weave.local 4000
Hello, Weave!
```
