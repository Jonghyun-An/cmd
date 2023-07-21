#!/bin/bash

source $(dirname $(realpath $0))/def_docker_config

if [ $# != 1 ]; then
    echo "Input docker command"
    echo "  ex) $0 ps"
    exit 1
fi

case "$1" in
    "ps")
        docker ps -a
        ;;
    "images")
        docker images
        ;;
    "history")
        docker history ${IMAGE_NAME}
        ;;
    "attach")
        docker attach ${CONTAINER_ID}
        ;;
    "start")
        docker start ${CONTAINER_ID}
        ;;
    "stop")
        docker stop ${CONTAINER_ID}
        ;;
    "rm")
        docker rm ${CONTAINER_ID}
        ;;
    "session")
        docker exec -it ${CONTAINER_ID} /bin/bash
        ;;
    "commit")
        docker commit ${CONTAINER_ID} ${IMAGE_NAME}
        ;;
    "push")
        docker login
        docker tag ${IMAGE_NAME} ${DOCKER_HUB_IMAGE_NAME}
        docker push ${DOCKER_HUB_IMAGE_NAME}
        docker rmi ${DOCKER_HUB_IMAGE_NAME}
        ;;
    "build")
        docker build -t ${IMAGE_NAME} ${CURRENT_DIR}
        ;;
    "run")
        docker run \
            -it \
            --name ${DOCKER_NAME} \
            --gpus '"device=0,1"' \
            --shm-size 4G \
            --volume "${WORKSPACE_DIR}:${WORKSPACE_DIR}" \
            --workdir="${WORKSPACE_DIR}" \
            ${IMAGE_NAME}
        ;;
    *)
        echo "'$1' is invalid command"
        exit 1
        ;;
esac