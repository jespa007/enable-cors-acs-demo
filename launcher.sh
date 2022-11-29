#!/bin/bash
echo ACS_TAG=$ACS_TAG
echo SHARE_TAG=$SHARE_TAG
echo NGINX_TAG=$NGNIX_TAG
echo TRANSFORMATION_CORE_TAG=$TRANSFORMATION_CORE_TAG
echo POSTGRES_TAG=$POSTGRES_TAG
echo ASS_TAG=$ASS_TAG
echo AMQ_TAG=$AMQ_TAG


if [ "$ACS_TAG" == "" ]
then
	echo "environmane variables not set"
	exit -1
fi


export COMPOSE_FILE_PATH="${PWD}/docker-compose.yml"
echo Docker compose file: $COMPOSE_FILE_PATH

buildImages() {
    docker-compose -f "$COMPOSE_FILE_PATH" build --no-cache
}

launch() {
    docker-compose -f "$COMPOSE_FILE_PATH" up --build
}


down() {
    if [ -f "$COMPOSE_FILE_PATH" ]; then
        docker-compose -f "$COMPOSE_FILE_PATH" down
    fi
}

purge() {
    PARENT_FOLDER=$(basename $PWD)
	echo PARENT_FOLDER: $PARENT_FOLDER
    docker volume rm -f ${PARENT_FOLDER}_acs-volume
    docker volume rm -f ${PARENT_FOLDER}_db-volume
    docker volume rm -f ${PARENT_FOLDER}_ass-volume
}

purgeAll() {
   docker volume prune -f
}

tail() {
    docker-compose -f "$COMPOSE_FILE_PATH" logs -f
}

case "$1" in
  build)
    buildImages
    ;;
  start)
    launch
    tail
    ;;
  stop)
    down
    ;;
  purge)
    down
    purge
    ;;
  purgeAll)
    down
    purgeAll
    ;;
  tail)
    tail
    ;;
  *)
    echo "Usage: $0 {build|start|stop|purge|tail}"
esac
