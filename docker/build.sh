#!/bin/bash

. settings.sh

docker build  \
    --build-arg USERNAME=${CONTAINER_USER} \
    --build-arg UUID=$UUID \
    --build-arg UGID=$UGID \
    -t sonarsim_bionic:devel .
