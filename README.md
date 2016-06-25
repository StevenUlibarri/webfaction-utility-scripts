# webfaction-utility-scripts
[Webfaction](https://my.webfaction.com/) SSH user utility scripts

## [Scripts](./scripts/README.md)
- [setup-new-user.sh](./scripts/README.md#setup-new-user) - sets up permissions for a new ssh user and a new webapp.
- [setup-ssh.sh](#setup-ssh) - sets up the ./ssh directory for a specified new ssh user.
- [grant-user-permission-for-webapp.sh](#grant-user-permission-for-webapp) - ensures the specified user has read and write permissions for the specified webapp.
- [clean-webapp-permissions](#clean-webapp-permissions) - removes access to the specified webapp for all users except for your main user.

### Motivation
When I create a new [*Application*][applications] on [Webfaction][webfaction] I also create an [SSH user][additional users] to manage it. I do this specifically to allow my apps to interact with various kinds of automation such as [CD/CD](https://circleci.com/) while remaining secure and isolated from my other apps. Unfortunately this can be confusing to setup on [Webfaction][webfaction]. Using the control panel to grant permission to an ssh user for one app in the `/webapps` directory results in that user having read permissions on every other subdirectory. Following the instructions outlined [here][permissions] you can achieve the desired security but it is rather tedious. I have written these scripts to make create a new application and ssh user for it quick an easy.

### Caveats
- This is my first substantial dive into shell scripting.
- I have tried to avoid using any features specific to `bash` or another fancy shell. They *should* work with any of the shells available on [Webfaction][webfaction].
- These scripts have very little error checking and make some assumptions about how you are going about this process which I will outline for each script.
- I don't *think* these scripts can do anything that would break any of your main account permissions.
- SSH users given permissions this way will still be able to `ls` the `/webapps` directory but will only be able to `cd` into the one(s) you have allowed.

### Contributing
Feedback and Additions are appreciated.
Feel Free to fork this repo and submit a pull request.

### To Do
- Add error checking
- Make scripts dynamic/interactive
- Add perl script to parse args

[webfaction]: https://my.webfaction.com/
[additional users]: https://my.webfaction.com/
[applications]: https://docs.webfaction.com/user-guide/websites.html?highlight=application#applications
[permissions]: https://docs.webfaction.com/software/general.html#granting-access-to-specific-users
