#!/bin/sh

set -e

MAIN_USER=$1
HOST=$2
MAIN_USER_KEY=$3
TARGET_APP=$4

echo
echo "CLEANING PERMISSIONS FOR $TARGET_APP"

(
  echo echo "Removing read, write, and execute access tp $TARGET_APP for all users that are not $MAIN_USER."
  echo setfacl -m o::---,default:o::--- '$HOME/webapps/'$TARGET_APP

) | ssh -T $MAIN_USER@$HOST -i $MAIN_USER_KEY
