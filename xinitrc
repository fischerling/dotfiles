#!/bin/bash
if type urxvt >/dev/null 2>/dev/null
then
    export  TERMINAL=urxvt

elif type terminator >/dev/null 2>/dev/null
then
    export TERMINAL=terminator
fi

exec i3 -V > /home/fischerling/.i3/log 
