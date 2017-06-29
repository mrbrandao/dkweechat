#!/bin/bash
#####################
#This script setup environment to run this container
#
# --- What it must do? ---
#   * Quest where is the ssh pub key
#   * Create a volume with chosed name
#
# by: isca
#####################
source ./colors

sshkey(){

  read -p "Full path for your public key: " pubkey
  export pubkey="$pubkey"

}

volcreate(){

  if ! docker volume inspect weechat > /dev/null 2>&1 ;then
    echo -e ""$green"Criando volume "$cyan"weechat"$clean""
    docker volume create --name weechat
    if [ -e $(pwd)/dkweechat.tar.gz ];then
      $0 restore
    fi
  fi

}
compose(){
  docker-compose up -d && docker-compose logs -f
}

backup(){

  if [ -e $(pwd)/dkweechat.tar.gz ]; then
    mv $(pwd)/dkweechat.tar.gz $(pwd)/dkweechat-$(date +%d-%m-%y-%N).tar.gz
  fi
  docker run --rm -v weechat:/data -v $(pwd):/backup --name weechatbkp alpine tar cvzf /backup/dkweechat.tar.gz /data

}

restore(){
  docker run --rm -v weechat:/data -v $(pwd):/backup --name restorewee alpine sh -c "tar xvzf /backup/dkweechat.tar.gz -C / ; chown -R 1000.1000 /data/weechat"
}

run(){
  sshkey;
  volcreate;
  compose;
}

helpme(){

    echo -e "\n"$whiteb""$red"Use: "$green""$0" "$cyan"run"$whiteb"|"$cyan"bkp"$whiteb"|"$cyan"restore"$whiteb"|"$cyan"help"$clean"\n"
    echo -e " 
      "$cyan"run      "$pink"-->"$clean"  Build container and run with docker-compose
      "$cyan"bkp      "$pink"-->"$clean"  Create a backup file "$red"dkweechat.tar.gz"$clean" with settings of the container vol
      "$cyan"restore  "$pink"-->"$clean"  Restore backup file dkweechat.tar.gz to the weechat volume
      "$cyan"help     "$pink"-->"$clean"  Diplay this help
      \n"
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
  ;;

  *)
    helpme
  ;;
    
esac

