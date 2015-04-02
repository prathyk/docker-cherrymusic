#!/usr/bin/bash

SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})
MUSIC_DIR=${MUSIC_DIR:-${HOME}/Music}
CONFIG_DIR=${CONFIG_DIR:-${SCRIPT_DIR}/config}
SHARED_DIR=${SHARED_DIR:-${SCRIPT_DIR}/share}

docker run --name docker-cherrymusic --rm -p 18100:8080 \
    --volume $MUSIC_DIR:/home/cm/basedir/music \
    --volume $CONFIG_DIR:/home/cm/.config/cherrymusic \
    --volume $SHARED_DIR:/home/cm/.local/share/cherrymusic \
    cherrymusic sh -c "cherrymusic $@"
