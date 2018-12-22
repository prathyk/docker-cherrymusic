FROM alpine:3.6
MAINTAINER Andreas Linz "klingt.net@gmail.com"

# install requirements
RUN apk update &&\
    apk add python3\
            ffmpeg\
            flac\
            curl

RUN pip3 install --upgrade pip &&\
    pip3 install cherrypy &&\
    pip3 install cherrymusic==0.40.0

# set locale
ENV LANG en_US.UTF-8

# create user that runs cherrymusic
RUN mkdir -p  ~/.config/cherrymusic ~/.local/share/cherrymusic ~/basedir

EXPOSE 8080

# mount your music folder into the basedir (docker run -v /path/to/music:/home/cm/basedir)
# and do the same for the config and share folder
VOLUME  /root/.config/cherrymusic \
        /root/.local/share/cherrymusic \
        /root/basedir

COPY entrypoint.sh /

WORKDIR /root
CMD /bin/sh -c 'cherrymusic --conf media.basedir=/root/basedir'
ENTRYPOINT ["/entrypoint.sh"]
