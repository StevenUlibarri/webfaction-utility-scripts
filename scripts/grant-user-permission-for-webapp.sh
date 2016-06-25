#!/bin/sh

set -e

MAIN_USER=$1
HOST=$2
MAIN_USER_KEY=$3
TARGET_USER=$4
TARGET_APP=$5

(
  echo setfacl -m u:$TARGET_USER:--x '$HOME'
  echo setfacl -m u:$TARGET_USER:--- '$HOME/webapps/*'
  echo setfacl -R -m u:$TARGET_USER:rwx '$HOME/webapps/'$TARGET_APP
  echo setfacl -R -m d:u:$TARGET_USER:rwx '$HOME/webapps/'$TARGET_APP
  echo chmod g+s '$HOME/webapps/'$TARGET_APP
  echo setfacl -R -m d:u:$MAIN_USER:rwx '$HOME/webapps/'$TARGET_APP
) | ssh $MAIN_USER@$HOST -i $MAIN_USER_KEY
