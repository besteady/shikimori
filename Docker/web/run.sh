#!/bin/bash
set -ex

# check that postgresql ready
until pg_isready
do
    sleep 5s
done

# db
psql -U postgres -d postgres \
    -c "create user shikimori_production;" \
    -c "create user shikimori_test;" \
    -c "alter user shikimori_production createdb;" \
    -c "alter user shikimori_test createdb;" \
    -c "alter user shikimori_production with superuser;" \
    -c "alter user shikimori_test with superuser;"

# create databases
rails db:create

# extensions
psql -U postgres -d shikimori_test_ \
    -c "create extension unaccent;" \
    -c "create extension hstore;" \
    -c "create extension pg_stat_statements;"

psql -U postgres -d shikimori_production \
    -c "create extension unaccent;" \
    -c "create extension hstore;" \
    -c "create extension pg_stat_statements;"

# restore from a backup
rails db:drop && rails db:create
unzip -d db/ db/dump.sql.zip
psql -U shikimori_production -d shikimori_production -f db/dump.sql
rm db/dump.sql
RAILS_ENV="test" rails db:schema:load

# run three times because there will be error you can avoid with new run
rails db:migrate || true
rails db:migrate || true
rails db:migrate

# start rails server
rails server

# rake i18n:js:export
# bin/webpack-dev-server
# bundle exec sidekiq -C config/sidekiq.yml
