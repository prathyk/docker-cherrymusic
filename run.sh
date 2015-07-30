#!/bin/sh

NAME=${cm:-'cm-alpine'}
HTTP_PORT=${1:-9090}
MUSIC_PATH=${2:-$HOME/Music}

docker run \
	--name ${NAME} \
	--publish ${HTTP_PORT}:8080 \
	--volumes-from cm-alpine-data \
	--volume ${MUSIC_PATH}:/home/cm/Music \
	-it cm-alpine
