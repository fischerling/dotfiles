#!/bin/bash

if type rofi &>/dev/null
then
    exec rofi -show run
else
    exec dmenu_run
fi
