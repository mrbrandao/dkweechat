#!/bin/sh

function start_weechat()
{
  if [ -f \"/home/weechat/.weechat/irc.conf\" ] ; then
    weechat
  else
    local config=$(cat config.txt | tr \"\\n\" \"\;\")
    weechat -r "${config}"
  fi
}

function start_tmux()
{
  if tmux has-session -t WeeChat >/dev/null; then
    tmux attach -t WeeChat 
  else
    tmux new -s WeeChat "$0" -u
  fi
}

export TERM="screen-256color"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if test $TMUX; then
  start_weechat
else
  start_tmux
fi
