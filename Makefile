.PHONY=build

NAME=cm-alpine
HTTP_PORT=9090
SSL_PORT=9443
MUSIC_PATH=~/Music

all: build data

backup:
	docker run --volumes-from $(NAME)-data -v $(shell pwd):/backup alpine tar cvzf /backup/backup.tar.gz /home/cm/{.local,.config}

build:
	docker build -t $(NAME) .

config:
	docker run --rm --volumes-from $(NAME)-data -it vim-alpine vim /home/cm/.config/cherrymusic/cherrymusic.conf

maintain:
	docker run --rm --volumes-from $(NAME)-data -it vim-alpine /bin/bash

data:
	docker create \
	--name $(NAME)-data \
	--volume /home/cm/.config/cherrymusic \
	--volume /home/cm/.local/cherrymusic \
	cm-alpine \
	sh -c "chown -R cm:cm /home/cm/.config /home/cm/.local"
