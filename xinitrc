#!/bin/bash
if type urxvt >/dev/null 2>/dev/null
then
    export  TERMINAL=urxvt

elif type terminator >/dev/null 2>/dev/null
then
    export TERMINAL=terminator
fi

eval $(ssh-agent -s -a ~/.ssh/agent.sock)

[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

exec i3 -V > $HOME/.i3/log 
