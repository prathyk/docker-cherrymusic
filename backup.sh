#!/bin/sh

# use this script to backup the contents of your cherrymusic-data container

if [ "$#" -ne 1 ]; then
    echo "USAGE: ./backup.sh /backuppath"
    exit 1
fi

if [ -d "$1" ]; then
    docker run --rm --volumes-from cherrymusic-data -v $1:/backup klingtdotnet/cherrymusic \
    tar cvzf /backup/cherrymusic_backup-$(date --iso-8601).tar.gz \
	/home/cm/.config/cherrymusic \
	/home/cm/.local/share/cherrymusic
else
    echo "\"$1\" is not a folder or does not exist"
fi
