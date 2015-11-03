#!/bin/bash

if type rofi &>/dev/null
then
    exec rofi -show ssh
else
    exec i3-nagbar -m "please install rofi to use the ssh starter" &>/dev/null
fi
