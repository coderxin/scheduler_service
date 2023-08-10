#!/usr/bin/env bash
test=`docker-compose --version`
if [ -z "$test" ]; then echo "Please install docker compose";  exit; fi

docker-compose build
docker-compose run --rm web bin/rails db:setup
docker-compose up
