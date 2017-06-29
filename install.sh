#!/bin/sh
#####################
# This is a simple script to install deploy this project
#
# by: isca
#####################
export weechat="weechat"
export pubkey="mypubkey"

#--- Setup ---
docker volume create --name "$weechat"

#--- Run ---
docker-compose up --build

