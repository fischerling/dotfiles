#!/bin/bash

if type rofi &>/dev/null
then
    cmd=$(rofi -show ssh)
elif type dmenu &>/dev/null
then
    
    cmd="ssh $(grep Host ~/.ssh/config | cut -f2 -d' ' | dmenu)"
else
    exec i3-nagbar -m "please install rofi or dmenu to use the ssh starter" &>/dev/null
fi


if [[ $cmd == *"ircbox"* ]] && [[ $TERMINAL == "urxvt" ]]
then
    exec i3-sensible-terminal -vb -e $cmd

else
    exec i3-sensible-terminal -e $cmd
fi

