# [cherrymusic](https://github.com/devsnd/cherrymusic) as a docker service

## Quickstart

- create the data-container:

```sh
docker create --name cherrymusic-data -v /home/cm/.config/cherrymusic -v /home/cm/.local/share/cherrymusic -v /path/to/local/music:/home/cm/basedir/:ro  prathyk/cherrymusic
```
```sh
docker run --name cherrymusic -p 127.0.0.1:2345:8080 -v /home/talip/.config/cherrymusic -v /home/talip/.local/share/cherrymusic -v /sdcard/Music/cherry:/home/talip/basedir -it prathyk/cherrymusic
```

- run once to create the initial configuration

```sh
docker run --rm --volumes-from cherrymusic-data -it prathyk/cherrymusic
```

- edit the configuration

```sh
docker run --rm --volumes-from cherrymusic-data -it prathyk/vim vim /home/cm/.config/cherrymusic/cherrymusic.conf
```

- normal run with read-only mounted music volume (or as SystemD service)

```sh
docker run --rm --volumes-from cherrymusic-data --volume /path/to/local/music:/home/cm/basedir/:ro -it prathyk/vim vim /home/cm/.¬config/cherrymusic/cherrymusic.conf
```

- start the docker directly

```sh
docker run --name cherrymusic -p 127.0.0.1:2345:8080 --volumes-from cherrymusic-data prathyk/cherrymusic
```
### SystemD Service

- copy the `cherrymusic@.service` file to `/etc/systemd/system` and run `systemctl daemon-reload`
- edit the environment file `cherrymusic` and copy it to `/etc/sysconfig`
- run the service with `systemctl start cherrymusic@someuser` or *enable* it (start automatically on boot) `systemctl enable cherrymusic@someuser`

### nginx Reverse Proxy Example

- to generate a self-signed certificate: `openssl req -x509 -newkey rsa:4096 -keyout music.klingt.net.pem -out music.klingt.net.crt -days 360`

```nginx
erver {
    listen 80;
    listen [::]:80;
    server_name music.some.domain;
    return 301 https://music.some.domain$request_uri;
}

server {
    listen       443 ssl spdy;
    listen       [::]:443 ssl spdy;
    server_name  music.some.domain;

    ssl_certificate         /etc/nginx/certs/_.some.domain/_.some.domain.pem;
    ssl_certificate_key     /etc/nginx/certs/_.some.domain/_.some.domain.key;
    ssl_password_file       /etc/nginx/certs/_.some.domain/.pass;

    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

    location / {
        proxy_http_version 1.1;
        # Set proxy headers for the passthrough
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # Let the Set-Cookie header through.
        proxy_pass_header Set-Cookie;
        proxy_pass  http://localhost:8765/;
    }
}
```

### SELinux Troublehshooting

- certificate not readable by nginx, despite correct permmissions -> update SELinux context

```sh
restorecon -v -R /path/to/certs/
```

- nginx returns `502 Bad Gateway` -> add port to allowed http ports

```sh
semanage port -a -t http_port_t -p tcp 20800
# check
semanage port -l | grep 20800
```

- note that `semanage` takes a lot of resources (I would like to know why), maybe you have to setup a swapfile for systems with less than 512MB of RAM. Otherwise it will stop with a `KILLED` message

