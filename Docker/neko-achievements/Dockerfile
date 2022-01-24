FROM elixir:1.13-alpine
WORKDIR /home/neko-achievements

RUN set -x \
    && apk add --no-cache build-base git openssh erlang bash \
    && git clone -b master --single-branch https://github.com/shikimori/neko-achievements.git . \
    && mix local.hex --force \
    && mix deps.get \
    && mix local.rebar --force \
    && sed -i 's/-lerl_interface //g' deps/yamler/c_src/Makefile
