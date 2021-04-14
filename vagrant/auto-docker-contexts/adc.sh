#!/usr/bin/env bash

# Parse some values from the output of 'vagrant ssh-config'
OUTPUT="$(vagrant ssh-config)"
ADDR="$(echo "$OUTPUT" | grep 'HostName' | awk '{print $2}')"
NAME="$(echo "$OUTPUT" | grep 'Host ' | awk '{print $2}')"

# Create a new Docker context for the Vagrant machine
docker context create "$NAME" \
--description "Automatically generated Docker context" \
--docker "host=ssh://"$ADDR""
