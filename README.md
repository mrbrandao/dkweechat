# dkweechat #

Weechat is a nice IRC client and this project gives you a nice docker container to use weechat and all your scripts.

This project was inspired and some part based on https://github.com/kerwindena/docker-weechat

## Installation ##

This is very simple to run, you need to specify the full path of your ssh public key and set this path on
variable ```pubkey```

E.g. ```$ set -a; export pubkey=/home/myuser/.ssh/id_rsa.pub;docker-compose up```

But here is a script to take this action even more simple, just run:

 ```
  ./setup.sh
 ```
Just run setup it give a very simple waltrought setup, to run this container automagicaly ;)

## Manually

If you want to understant what it's dooing manually, its basic this steps:

  1. export pubkey=path_to_my_key
  2. check if the volume weechat hexist if not create (This volume is where your settings will persist)
  3. check if you altready have a backup and if it exist restore them on weechat volume
  4. docker-compose up -d && docker-compose logs -f
  
_Ps. the weechat volume name is hardcoded and if already have one volume with this same name it will create a data folder inside to use weechat_




## FAQ ##

How can i access the weechat?

_You access weechat from ssh connection over port 5000 on your host_
_For example if you run on your localmachine you can access with ```ssh weechat@localhost -p 5000```_

Can i backup my weechat files? How?

_Yes you can backup all your settings on a tarball file.
_ Just run ```./setup.sh bkp``` and it gone build a main taball called **weechat.tar.gz** on the root folder_
_ of this project._

How can i restore my files?

_Just place a filed called weechat.tar.gz on the root folder of this project and it will be restored._
_This restore will only work for files backuped with ```setup.sh bkp``` command._


## Requirements ##

 * docker
 * docker-compose

## Author ##
 _               
(_)___  ___ __ _ 
| / __|/ __/ _` |
| \__ \ (_| (_| |
|_|___/\___\__,_|
[isca.space|isca]


