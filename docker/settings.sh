#!/bin/bash

# Set Sonarsim's home path here
SONARSIM_PATH="$HOME/workspace/sonarsim_bionic"

# Don't change these unless you know what you are doing
USERNAME="$(id -nu)"
UUID="$(id -u)"
UGID="$(id -g)"

export SONARSIM_PATH
export USERNAME
export UUID
export UGID
