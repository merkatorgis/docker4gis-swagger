#!/bin/bash
set -e

IMAGE=$IMAGE
CONTAINER=$CONTAINER
DOCKER_ENV=$DOCKER_ENV
RESTART=$RESTART
NETWORK=$NETWORK
FILEPORT=$FILEPORT
VOLUME=$VOLUME

proxy=$PROXY_HOST
[ "$PROXY_PORT" ] && proxy=$proxy:$PROXY_PORT
API_URL=${API_URL:-https://$proxy/$DOCKER_USER/api}

docker container run --restart "$RESTART" --name "$CONTAINER" \
	-e API_URL="$API_URL" \
	-e DOCKER_ENV="$DOCKER_ENV" \
	--network "$NETWORK" \
	-d "$IMAGE" swagger "$@"
# --mount type=bind,source="$FILEPORT",target=/fileport \
# --mount source="$VOLUME",target=/volume \
