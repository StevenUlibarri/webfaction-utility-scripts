#!/bin/sh

set -e

NEW_USER=$1
HOST=$2
NEW_USER_PUB_KEY=$3

RAW_KEY=$(cat $NEW_USER_PUB_KEY)

(
  echo mkdir '$HOME'/.ssh
  echo touch '$HOME'/.ssh/authorized_keys

  echo chmod 600 '$HOME'/.ssh/authorized_keys
  echo chmod 700 '$HOME'/.ssh
  echo chmod go-w '$HOME'

  echo "echo $RAW_KEY >>" '$HOME/.ssh/authorized_keys'
) | ssh $NEW_USER@$HOST
