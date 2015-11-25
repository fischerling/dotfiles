#!/bin/bash

if type rofi &>/dev/null
then
    exec rofi -show ssh
elif type dmenu &>/dev/null
then
    
    exec i3-sensible-terminal -e ssh $(grep Host ~/.ssh/config | cut -f2 -d' ' | dmenu)
else
    exec i3-nagbar -m "please install rofi or dmenu to use the ssh starter" &>/dev/null
fi
