#!/bin/bash

. settings.sh

docker build  \
    --build-arg USERNAME=$USERNAME \
    --build-arg UUID=$UUID \
    --build-arg UGID=$UGID \
    -t sonarsim_bionic:devel .
