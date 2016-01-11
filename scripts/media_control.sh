#!/bin/bash

#TODO
# NOTE:
# if spotify is running toggle is consumed by spotify.

# arg parsing
if [ "$1" = "toggle" ]
then
    spotify_cmd="PlayPause"
elif [ "$1" = "next" ]
then
    spotify_cmd="Next"
elif [ "$1" = "prev" ]
then
    spotify_cmd="Previous"
fi

if [ "$spotify_cmd" != "" ]
then
    # can't be sure if spotify was running and should play again
    if [ "$spotify_cmd" = "PlayPause" ]
    then
        if [ "$(ps -A | grep spotify)" != "" ]
        then
            dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$spotify_cmd
        else
            mpc $1
        fi
    elif [ "$(lsof | grep /dev/snd | grep spotify)" != "" ]
    then
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$spotify_cmd
    elif [ "$(mpc | grep '\[' | cut -f1 -d' ')" != "" ]
    then
        mpc $1 &>/dev/null
    fi
fi
