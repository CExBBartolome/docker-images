#!/bin/sh

# From https://github.com/SvenDowideit/docs-automation/blob/master/jenkins/setup-docker-and-start-jenkins.sh
set -e

JUSER="jenkins"
DOCKER_GROUP="dockergrp"

DOCKER_GID=$(ls -aln /var/run/docker.sock  | awk '{print $4}')

if ! getent group $DOCKER_GID; then
  echo creating $DOCKER_GROUP group $DOCKER_GID
  addgroup --gid $DOCKER_GID $DOCKER_GROUP
else
  DOCKER_GROUP=$(getent group $DOCKER_GID | cut -f 1 -d :)
fi

if ! id -nG "$JUSER" | grep -qw "$DOCKER_GROUP"; then
  adduser $JUSER $DOCKER_GROUP
fi

/usr/sbin/sshd -D
