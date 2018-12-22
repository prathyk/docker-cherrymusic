#!/bin/sh
rm -f /root/.local/share/cherrymusic/cherrymusic.pid

exec "$@"
