#!/bin/bash
set -ex

until test -f config/sidekiq.yml
do
    sleep 30s
done

bundle exec sidekiq -C config/sidekiq.yml
