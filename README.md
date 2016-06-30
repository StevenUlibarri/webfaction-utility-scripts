# webfaction-utility-scripts
[Webfaction](https://my.webfaction.com/) SSH user utility scripts

### Why?
Managing permissions for additional ssh users on webfaction is annoying, especially if you require strict isolation between apps. A new user granted permissions to a single subdirectory within the `/home/main-user/webapps/` directory via the control panel receives read access to every other webapp subdirectory as well. This user also automatically has access to any new applications created. There is a way to grant permissions without these side effects documented [here](permissions) but it is quite tedious. I have written these scripts to make managing these permissions easier.

### Assumptions
These scripts make the following assumptions about you:
- You already have ssh key authentication enabled for you main user.
- All of your apps live in the `/home/main-user/webapps/` directory.
- Users you want to manage permissions for:
  - are new users with no permissions already granted or otherwise changed
  - do not belong to any additional user groups.

### Notice
Any users or apps you wish to manipulate with these scripts must have already been created via the webfaction control panel. **These scripts WILL NOT create new users and/or apps for you**.


### Scripts
#### clean-webapp-permissions
- usage: `sh ./clean-webapp-permissions.sh <main-user> <host> <main-user-key> <target-app>`
- args:
  - `main-user` - the username of your main account.
  - `host` - the address of your webfaction webserver, usually `webNNN.webfaction.com` or `mainuser.webfactional.com`.
  - `main-user-key` - the path to the ssh private key used by your main user.
  - `target-app` - the name of the app you wish to restrict access to.

Revokes all permissions to the specified webapp directory except those held by your main user. Useful when you have just created a new app and want to remove the default access existing ssh users may have been given to it.

#### setup-ssh
- usage: `sh ./setup-ssh/sh <user> <host> <user-pub-key>`
- args:
  - `user` - the name of the user you want to set up ssh for.
  - `host` - the address of your webfaction webserver, usually `webNNN.webfaction.com` or `mainuser.webfactional.com`.
  - `user-pub-key` - the path to the ssh public key you wish to authorize for this user.

After prompting for the user's ssh password this script does three things:
- Creates all of the files and directories required to enable ssh key authentication.
- Sets the permissions required to enable ssh key authentication.
- Writes the specified key to `/home/user/.ssh/authorized_keys`.

This script can also be used to add public keys to users that are already configured to use key authentication. Be aware that running the script multiple times with the same key and the same user will create multiple entries for the key in that user's `authorized_keys` file.

#### grant-user-permission-for-webapp
- usage: `sh ./grant-user-permission-for-webapp.sh <main-user> <host> <main-user-key> <target-user> <target-app>`
- args:
  - `main-user` - the username of your main account.
  - `host` - the address of your webfaction webserver, usually `webNNN.webfaction.com` or `mainuser.webfactional.com`.
  - `main-user-key` - the path to the ssh private key used by your main user.
  - `target-user` - the user you wish you grant read/write/execute permissions to.
  - `target-app` - the app the user will have those permission for.

This script does five things:
- Allows the specified user to find directories that it has access in your main user's home directory. Basically enables the user to traverse the file path to the app it is getting permissions for.
- Removes the specified user's permissions on all other webapp directories. **This script assumes additional users and apps have a one to one relationship. If the specified user is meant to have access to multiple apps do not use this script.**
- Grants the specified user read, write, and execute permissions for the specified app.
- Ensures the same permissions will be applied to files and directories created in the specified app in the future.
- Sets the same permissions for the main user.

The result is an ssh user that can traverse to the main users webapps directory, can see all the app directories within, but can only enter and work in the app specified in the script. This process is described in the webfaction docs [here](permissions).

#### setup-new-user
- usage: `sh ./setup-new-user.sh <main-user> <host> <main-user-key> <new-user> <new-user-key> <new-user-pub-key> <new-app>`
- args:
  - `main-user` - the username of your main account.
  - `host` - the address of your webfaction webserver, usually `webNNN.webfaction.com` or `mainuser.webfactional.com`.
  - `main-user-key` - the path to the ssh private key used by your main user.
  - `new-user` - the new user that is meant to have access to the specified new app.
  - `new-user-key` - the path to the ssh private key that will be used by the new user.
  - `new-user-pub-key` - the path to the ssh public key that will be used by the new user.
  - `new-app` - the new app that the new user will have access to.

Uses the above scripts to:
- Ensure no other users can access the specified new app. (except the main user)
- Set up ssh key authentication for the new user using the specified ssh keys.
- Grants the new user read, write, and execute permission for the specified new app.

For convenience, the script also creates a symlink to the specified app's directory in the user's home directory.

### Contributing
Feel Free to fork this repo and submit a pull request.

### To Do
- Add args validation
- Make scripts dynamic/interactive

[webfaction]: https://my.webfaction.com/
[permissions]: https://docs.webfaction.com/software/general.html#granting-access-to-specific-users
