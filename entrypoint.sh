#!/bin/sh
chown ${CM_USER}:${CM_USER} /home/${CM_USER}/.config/cherrymusic /home/${CM_USER}/.local/share/cherrymusic /home/${CM_USER}/basedir
rm -f /home/${CM_USER}/.local/share/cherrymusic/cherrymusic.pid

exec "$@"
