#!/bin/sh

MAIN_USER=$1
HOST=$2
MAIN_USER_KEY=$3

NEW_USER=$4
NEW_USER_KEY=$5
NEW_USER_PUB_KEY=$6
NEW_USER_APP=$7

S="\'s"

echo "SETTING UP NEW USER $NEW_USER FOR APP $NEW_USER_APP"

sh ./clean-webapp-permissions.sh $MAIN_USER $HOST $MAIN_USER_KEY $NEW_USER_APP
sh ./setup-ssh.sh $NEW_USER $HOST $NEW_USER_PUB_KEY
sh ./grant-user-permission-for-webapp.sh $MAIN_USER $HOST $MAIN_USER_KEY $NEW_USER $NEW_USER_APP

(
  echo echo "Creating symlink to $NEW_USER_APP in $NEW_USER$S home directory."
  echo ln -s "/home/$MAIN_USER/webapps/"$NEW_USER_APP '$HOME'

) | ssh -T $NEW_USER@$HOST -i $NEW_USER_KEY
