# ------------------------------------------------------
#                       Dockerfile
# ------------------------------------------------------
# image:    autosub-docker
# name:     cic1988/autosub-docker
# authors:  gaoyuanhot@gmail.com
# ------------------------------------------------------

FROM jrottenberg/ffmpeg:3.2-alpine AS ffmpeg
FROM python:3.7.6-alpine3.9

# see: https://github.com/jrottenberg/ffmpeg/issues/99#issuecomment-400154614
COPY --from=ffmpeg / /

WORKDIR /autosub

# see: https://github.com/Docker-Hub-frolvlad/docker-alpine-mono/issues/9
RUN apk add --no-cache musl\>1.1.20 --repository http://dl-cdn.alpinelinux.org/alpine/edge/main

# install git
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# install autosub
RUN pip3 install git+https://github.com/BingLingGroup/autosub.git@origin

ENTRYPOINT ["autosub"]


