FROM node:alpine
WORKDIR /home/camo
RUN set -x \
    && apk add --no-cache git openssh bash \
    && git clone -b master --single-branch https://github.com/shikimori/camo-server.git . \
    && yarn
