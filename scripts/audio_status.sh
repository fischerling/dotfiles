#!/bin/bash

function print_mute {
   echo -n "M " 
}

function print_unmute {
   echo -n "U " 
}

if type pamixer &>/dev/null
then
    if pamixer --get-mute &> /dev/null
    then
        print_mute
    else
       print_unmute
   fi

   echo -n $(pacmd info | grep 'Default sink' | grep -o '[^.]*$')

   echo " [$(pamixer --get-volume)%]"

elif type amixer &>/dev/null
then
    if [[ "$(amixer sget Master | grep '\[on\]')" == "" ]]
    then
        print_mute
    else
        print_unmute
    fi

    echo -n "Volume: "

    echo "[$(amixer sget Master | grep Mono: | sed -e 's/[ \t]*Mono: Playback [0-9]* \[\([0-9]*%\)\].*/\1/')]"
else
    echo "please install either pamixer or amixer"
fi
