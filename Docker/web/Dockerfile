FROM ruby:2.6.8
WORKDIR /home/shiki

# install nodejs, postgresql-client, bundler
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs npm postgresql-client \
    && npm install -g yarn \
    && gem install bundler:2.2.26 \
    && rm -rf /var/lib/apt/lists/*

# install nodejs deps
COPY package.json yarn.lock ./
RUN set -x \
    && yarn install

# install ruby deps
COPY Gemfile Gemfile.lock ./
RUN set -x \
    && bundle install -j2 \
    && apt-get purge -y --auto-remove

COPY . .
