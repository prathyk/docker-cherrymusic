#!/usr/bin/bash

SCRIPT_ROOT=$(dirname ${BASH_SOURCE[0]})
MUSIC_PATH=${MUSIC_PATH:-${HOME}/Music}
CONFIG_PATH=${CONFIG_PATH:-${SCRIPT_ROOT}/config}
SHARED_PATH=${SHARED_PATH:-${SCRIPT_ROOT}/share}

docker run --name docker-cherrymusic --rm -p 18100:8080 \
    --volume $MUSIC_PATH:/home/cm/basedir/music \
    --volume $CONFIG_PATH:/home/cm/.config/cherrymusic \
    --volume $SHARED_PATH:/home/cm/.local/share/cherrymusic \
    cherrymusic sh -c "cherrymusic $@"
