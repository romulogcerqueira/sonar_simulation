#!/bin/bash

# The name of the user inside the container.
CONTAINER_USER="sonarsim"

# The host name of the container.
CONTAINER_HOSTNAME="bionic"

# Set Sonarsim's home path here
SONARSIM_PATH="${HOME}/workspace/sonarsim_bionic"

# Don't change these unless you know what you are doing
UUID="$(id -u)"
UGID="$(id -g)"