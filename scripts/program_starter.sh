#!/bin/sh

if type rofi &>/dev/null
then
    exec rofi -show run
elif type dmenu_run &>/dev/null
then
    exec dmenu_run
else
    i3-nagbar -m "please install rofi or dmenu to start a program" &>/dev/null
fi
