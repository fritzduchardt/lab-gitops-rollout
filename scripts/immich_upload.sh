#!/usr/bin/env bash

export IMMICH_API_KEY="${1:?Provide Immich API Key}"
export IMMICH_INSTANCE_URL="${2:-http://immich.friclu/api}"
docker run --network host -it -v "$(pwd)":/import:ro -e IMMICH_INSTANCE_URL -e IMMICH_API_KEY \
  ghcr.io/immich-app/immich-cli:latest upload --recursive -a /import
