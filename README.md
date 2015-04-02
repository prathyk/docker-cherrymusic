# [cherrymusic](https://github.com/devsnd/cherrymusic) as a docker service

## preparations

- enter the path to your music folder as the value of the `basedir` key in `/config/cherrymusic.conf.org` and save the file without the `.org` extension
- create the `share` directory where cherrymusics cache and database will be stored
- enter the absolute path to the `run.sh` script in the `ExecStart` task of the systemd unit file and save the file w/o the `.org` extension as well

### build the image

`docker build -t cherrymusic .`

This could take a while, because there is a lot of stuff to install.

### run script

**WARNING**: When you start cherrymusic for the first time, you will be asked to create an admin user in the web frontend. Make sure that your service is not accessible from the web when you do this! It's not possible to create the admin user with cherrymusic's CLI at the moment.

If you want to use the default paths, you can run `./run.sh` and you're good to go, else set the desired paths with one or more environment variables, like this:

```sh
MUSIC_DIR=/path/to/music/dir CONFIG_DIR=/path/to/config ./run.sh
```

## systemd service file

```sh
cp docker-cherrymusic@.service /usr/lib/systemd/system
systemd start docker-cherrymusic@${USER}
# to start it automatically on boot
systemd enable docker-cherrymusic@${user}
```

