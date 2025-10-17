#!/usr/bin/env bash

export IMMICH_API_KEY="${1:?Provide Immich API Key}"
# run locally
#ssh root@friclu-1-c socat TCP-LISTEN:80,reuseaddr,fork TCP:immich-server.immich:2283
#export IMMICH_INSTANCE_URL="${2:-http://friclu-1-c/api}"
export IMMICH_INSTANCE_URL="${2:-https://immich.duchardt.net/api}"
docker run --network host -it -v "$(pwd)":/import:ro -e IMMICH_INSTANCE_URL -e IMMICH_API_KEY \
  ghcr.io/immich-app/immich-cli:latest upload --recursive -a /import
