#!/bin/sh

function print_mute {
   echo -n "M " 
}

function print_unmute {
   echo -n "U " 
}

if type pamixer &>/dev/null
then
    muted="$(pamixer --get-mute)"
    if test ! $? || test "$muted" == "true"
    then
        print_mute
    else
        print_unmute
   fi

   if type pacmd &>/dev/null
   then
       echo -n $(pacmd info | grep 'active port.*output' | cut -d"-" -f3 | sed "s/>//") ""
   fi

   echo "[$(pamixer --get-volume)%]"

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
