#!/bin/bash

. settings.sh

if [ ! -d "$SONARSIM_PATH" ]; then
    mkdir -p "$SONARSIM_PATH"

    if [ ! -d "$SONARSIM_PATH" ]; then
        echo "Could not create Sonarsim's home"
        exit 1
    fi
fi

if [ ! -d "$SONARSIM_PATH/.ssh" ]; then
    if [ ! -d "$HOME/.ssh" ]; then
        printf "Please, setup ssh keys before running the container\n"

        exit 1
    fi
    cp -R "$HOME/.ssh" "$SONARSIM_PATH/"
fi

if [ ! -f "$SONARSIM_PATH/.gitconfig" ]; then
    if [ ! -f "$HOME/.gitconfig" ]; then
        printf "Please, setup git before running the container\n\n"
        printf "Use: \n"
        printf "git config --global user.name \"John Doe\"\n"
        printf "git config --global user.email johndoe@example.com\n"

        exit 1
    fi
    cp "$HOME/.gitconfig" "$SONARSIM_PATH/"
fi

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist "${DISPLAY}" | sed -e 's/^..../ffff/' | xauth -f "${XAUTH}" nmerge -

CONTAINER_NAME="sonarsim_bionic"

if [ ! "$(docker ps -q -f name=${CONTAINER_NAME}_devel)" ]; then
    if [ ! "$(docker ps -aq -f status=exited -f name=${CONTAINER_NAME}_devel)" ]; then
        echo "Create docker"
        docker create -it \
            --net host \
            --volume="${SONARSIM_PATH}:${HOME}:rw" \
            --volume="/etc/localtime:/etc/localtime:ro" \
            --env="TERM" \
            --user="${USERNAME}" \
            --workdir="/home/${USERNAME}" \
            --name ${CONTAINER_NAME}_devel \
            --privileged \
            --runtime=nvidia \
            --volume=${XSOCK}:${XSOCK}:rw \
            --volume=${XAUTH}:${XAUTH}:rw \
            --env=XAUTHORITY=${XAUTH} \
            --env=DISPLAY \
            ${CONTAINER_NAME}:devel
    fi
    echo "Start docker"
    docker start -ai ${CONTAINER_NAME}_devel
else
    echo "Exec docker"
    docker exec -ti ${CONTAINER_NAME}_devel /bin/bash
fi
