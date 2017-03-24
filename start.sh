#!/bin/sh

# From https://github.com/SvenDowideit/docs-automation/blob/master/jenkins/setup-docker-and-start-jenkins.sh
set -e

DOCKER_GROUP=$(ls -al /var/run/docker.sock  | awk '{print $4}')
if ! id -nG "$JUSER" | grep -qw "$DOCKER_GROUP"; then
  adduser $JUSER $DOCKER_GROUP
fi

/usr/sbin/sshd -D

