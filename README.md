# dkweechat aka Docker Weechat #


<p align="center">
  <img src="https://github.com/isca0/dkweechat/blob/master/shots/weechat-shot.png"/>
<!-- ![Docker Weechat Tmux](https://github.com/isca0/dkweechat/blob/master/shots/shot.png) --> 
</p>

Weechat is a nice IRC client and this project gives you a nice docker container to use weechat and all your scripts.
Yes, it's very cool now you be able to stay connect forever on IRC network, and you can also add you favorite Slack teams too... All you will need is an ssh connection to this container and voilá,
you are ready to stay live forever on a tmux stick session on all your favorite channels...

This project was inspired and some part based on https://github.com/kerwindena/docker-weechat

## Installation ##

This is a very simple project, all you need is basically an ssh public key, if dont have one yet,
you can make one with the command ```ssh-keygen```.
All wee need, is map your public ssh key on this docker container.
You can do this in several ways... The easy way is use the **setup.sh** script...

<p align="center">
  <img src="https://github.com/isca0/dkweechat/blob/master/shots/setup.png"/>
</p>

To take this action even more simple, just run:

 ```
  ./setup.sh run
 ```

Just run setup and it will guide you trough a simple steps and run this container :crystal_ball: automagically :crystal_ball:


## Manually

This is very simple to run, you need to specify the full path of your ssh public key and set this path on
variable **pubkey**

You can do like this:

E.g. ```$ set -a; export pubkey=/home/myuser/.ssh/id_rsa.pub;docker-compose up```

Or you can just place you full ssh public key path on docker-compose.yml on volumes group.

```
  volumes:
    - full_path_to_your_key:/home/weechat/.ssh/authorized_keys:ro

```

If you want to understant what it's dooing manually:

  * export pubkey=path_to_my_key
  * check if the volume weechat exist and if not  then create. (This volume is where your settings will be persisted)
  * check if you already have a backup and if it exist restore them on weechat volume
  * docker-compose up -d && docker-compose logs -f
  
_Ps. the weechat volume name is hardcoded and if already have one volume with this same name it will create a data folder inside to use weechat_


## FAQ ##

**How can i access the weechat?**

- _You access weechat trough ssh connection over port 5000 on your host_
_For example if you run on your localmachine you can access with ```ssh weechat@localhost -p 5000```_

**Can i backup my weechat settings and files? How?**

- _Yes you can backup all your settings on a tarball file.
_ Just run ```./setup.sh bkp``` and it gon build a main tarball called **dkweechat.tar.gz** on the root folder of this project._

**How can i restore my files?**

- _Just place a filed called dkweechat.tar.gz on the root folder of this project and it will be restored with command ```./setup.sh restore```._
_This restore will only work for files backuped by the command ```setup.sh bkp``` ._

**How run without auto restore?**

- _Just remove file dkweechat.tar.gz from main root folder of this project._


## Requirements ##

 * docker
 * docker-compose

## Author ##


```_               
 (_)              
  _ ___  ___ __ _ 
 | / __|/ __/ _` |
 | \__ \ (_| (_| |
 |_|___/\___\__,_|
 ```
[By: isca space](isca.space):robot:


