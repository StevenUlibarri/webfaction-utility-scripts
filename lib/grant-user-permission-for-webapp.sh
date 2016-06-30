#!/bin/sh

set -e

MAIN_USER=$1
HOST=$2
MAIN_USER_KEY=$3
TARGET_USER=$4
TARGET_APP=$5

S="\'s"

echo
echo "GRANTING PERMISSIONS ON $TARGET_APP to $TARGET_USER"

(
  echo echo "Allowing $TARGET_USER account to locate directories that it has access to within $MAIN_USER$S home directory."
  echo setfacl -m u:$TARGET_USER:--x '$HOME'

  echo echo "Removing $TARGET_USER$S default access to the applications in your $HOME/webapps directory."
  echo setfacl -m u:$TARGET_USER:--- '$HOME/webapps/*'

  echo echo "Granting $TARGET_USER read, write, and execute access to the $TARGET_APP$S files and directories."
  echo setfacl -R -m u:$TARGET_USER:rwx '$HOME/webapps/'$TARGET_APP

  echo echo "Granting $TARGET_USER read, write, and execute access to any files and directories created in $TARGET_APP in the future."
  echo setfacl -R -m d:u:$TARGET_USER:rwx '$HOME/webapps/'$TARGET_APP

  echo echo "Setting $MAIN_USER$S group as the owner of any new files in the $TARGET_APP$S directory."
  echo chmod g+s '$HOME/webapps/'$TARGET_APP

  echo echo "Granting $MAIN_USER full access to files in $TARGET_APP directory, including any files created in the future by $TARGET_USER."
  echo setfacl -R -m d:u:$MAIN_USER:rwx '$HOME/webapps/'$TARGET_APP

) | ssh -T $MAIN_USER@$HOST -i $MAIN_USER_KEY
