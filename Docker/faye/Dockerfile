FROM node:alpine
WORKDIR /home/faye
RUN set -x \
    && apk add --no-cache git openssh bash \
    && git clone -b master --single-branch https://github.com/shikimori/faye-server.git . \
    && yarn
