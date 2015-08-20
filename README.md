# [cherrymusic](https://github.com/devsnd/cherrymusic) as a docker service

## Quickstart

TODO

## SystemD Service

```sh
cp docker-cherrymusic@.service /usr/lib/systemd/system
systemctl start docker-cherrymusic@${USER}
# to start it automatically on boot
systemctl enable docker-cherrymusic@${user}
```

