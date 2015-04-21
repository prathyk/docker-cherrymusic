# http://phusion.github.io/baseimage-docker/#solution
FROM phusion/baseimage:latest
MAINTAINER Andreas Linz "klingt.net@gmail.com"

# install requirements
RUN apt-get update &&\
    apt-get install -y\
    faad\
    flac\
    imagemagick\
    lame\
    mpg123\
    python3-pip\
    sqlite\
    vorbis-tools &&\
    rm -rf /var/lib/apt/lists/*

# set locale
RUN locale-gen en_US.UTF-8 &&\
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

# I have to install it in seperate steps because cherrymusic wouldn't find cherrypy otherwise
RUN pip3 install cherrypy &&\
    mkdir /opt/cherrymusic &&\
    curl -L "https://github.com/devsnd/cherrymusic/archive/master.tar.gz" | tar xz --strip-components 1 --directory /opt/cherrymusic &&\
    ln -s /opt/cherrymusic/cherrymusic /usr/bin

# create user that runs cherrymusic
RUN useradd --create-home --shell /usr/bin/nologin cm
RUN su -s /bin/sh cm -c "mkdir -p ~/basedir \
    ~/.config/cherrymusic \
    ~/.local/share/cherrymusic"

EXPOSE 8080

# mount your music folder into the basedir (docker run -v /path/to/music:/home/cm/basedir)
# and do the same for the config and share folder
VOLUME /home/cm/basedir /home/cm/.config/cherrymusic /home/cm/.local/share/cherrymusic

USER    cm
ENV     HOME /home/cm
WORKDIR /home/cm
CMD     cherrymusic
