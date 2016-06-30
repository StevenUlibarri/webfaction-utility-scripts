#!/bin/sh

set -e

USER=$1
HOST=$2
USER_PUB_KEY=$3

RAW_KEY=$(cat $USER_PUB_KEY)

echo
echo "SETTING UP SSH FOR $USER"

(
  echo echo 'Creating .ssh directory.'
  echo mkdir '$HOME'/.ssh

  echo echo 'Creating ./ssh/authorized_keys file.'
  echo touch '$HOME'/.ssh/authorized_keys

  echo echo '"Setting required permissions on $HOME, $HOME/.ssh, and $HOME/.ssh/authorized_keys."'
  echo chmod 600 '$HOME'/.ssh/authorized_keys
  echo chmod 700 '$HOME'/.ssh
  echo chmod go-w '$HOME'

  echo echo "Writing $USER_PUB_KEY to" '$HOME/.ssh/authorized_keys.'
  echo "echo $RAW_KEY >>" '$HOME/.ssh/authorized_keys'

) | ssh -T $USER@$HOST
