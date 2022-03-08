#!/bin/bash

# Set Sonarsim's home path here
SONARSIM_PATH="$HOME/workspace/sonarsim_bionic"

# Don't change these unless you know what you are doing
USER="$(id -nu)"
UUID="$(id -u)"
UGID="$(id -g)"

export SONARSIM_PATH
export USER
export UUID
export UGID
