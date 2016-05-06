# weave-in-docker
A PoC for running Weave as a system-docker container in RancherOS

```bash
eval $(./run_weave_env.sh)

docker run -d \
       --name=pingme \
       gliderlabs/alpine \
nc -p 4000 -ll -e echo 'Hello, Weave!'

docker run -it \
       --name=pinger \
       gliderlabs/alpine \
sh -l

# inside pinger
ping -c3 pingme.weave.local
echo "What's up?" | nc pingme.weave.local 4000
```