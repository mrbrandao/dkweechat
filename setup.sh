#!/bin/sh
#####################
#This script setup environment to run this container
#
# --- What it must do? ---
#   * Quest where is the ssh pub key
#   * Create a volume with chosed name
#
# by: isca
#####################

sshkey(){

  read -p "Full path for your public key: " pubkey
  export pubkey="$pubkey"

}

volcreate(){

  if ! docker volume inspect weechat > /dev/null 2>&1 ;then
    echo -e ""$green"Criando volume "$cyan"weechat"$clean""
    docker volume create --name weechat
    if [ -e $(pwd)/weechat.tar.gz ];then
      $0 restore
    fi
  fi

}
compose(){
  docker-compose up -d && docker-compose logs -f
}

backup(){

  if [ -e $(pwd)/weechat.tar.gz ]; then
    mv $(pwd)/weechat.tar.gz $(pwd)/weechat-$(date +%d-%m-%y-%N).tar.gz
    docker run --rm -v weechat:/data -v $(pwd):/backup --name weechatbkp alpine tar cvzf /backup/weechat.tar.gz /data
  else
    docker run --rm -v weechat:/data -v $(pwd):/backup --name weechatbkp alpine tar cvzf /backup/weechat.tar.gz /data
  fi

}

restore(){
  docker run --rm -v weechat:/data -v $(pwd):/backup --name restorewee alpine sh -c "tar xvzf /backup/weechat.tar.gz -C / ; chown -R 1000.1000 /data/weechat"
}

run(){
  sshkey;
  volcreate;
  compose;
}

case $1 in

  run)
    run
  ;;

  bkp)
    backup
  ;;

  restore)
    restore
  ;;

  help)
    echo -e "\nUse: "$0" run|bkp|restore\n"
  ;;

  *)
    run
  ;;
    
esac

