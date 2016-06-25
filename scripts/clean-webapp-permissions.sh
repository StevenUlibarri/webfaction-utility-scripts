#!/bin/sh

set -e

MAIN_USER=$1
HOST=$2
MAIN_USER_KEY=$3
TARGET_APP=$4

(
  echo setfacl -m o::---,default:o::--- '$HOME/webapps/'$TARGET_APP
) | ssh $MAIN_USER@$HOST -i $MAIN_USER_KEY
