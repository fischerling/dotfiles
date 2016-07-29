#!/bin/bash

# To start the correct Player this script uses the file /tmp/media_control_last
f="/tmp/media_control_last"

function spotify_send_command {
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$1
}

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
    # check if spotify and mpd are running
    if pgrep spotify &>/dev/null
    then
        spotify_running=true
    else
        spotify_running=false
    fi

    if pgrep mpd &>/dev/null
    then
        mpd_running=true
        if type mpc &>/dev/null
        then
            mpd_controllable=true
        else
            mpd_controllable=false
        fi
    else
        mpd_running=false
    fi

    # both are running -> decide who gets the command
    # the playing program gets the commands 
    if $spotify_running && $mpd_running
    then
        if ! $mpd_controllable
        then
            spotify_send_command $spotify_cmd
            >&2 echo "mpd is running put mpc is not available to control it!"
            exit
        fi

        spotify_playing=$($DOTFILES_LOCATION/scripts/media_is_spotify_playing.sh)
        if mpc | grep "\[playing\]" &> /dev/null
        then
            mpd_playing=true
        else
            mpd_playing=false
        fi

        if $spotify_playing && $mpd_playing
        then
            >&2 echo "mpd and spotify are playing!"
        elif $spotify_playing
        then
            spotify_send_command $spotify_cmd
            echo spotify > $f
        elif $mpd_playing
        then
            mpc $1
            echo mpd > $f
        # nothing is actually running
        # read last running file
        else
            if [ -f $f ]
            then
                last=$(cat $f)

                if [ $last = "spotify" ]
                then
                    spotify_send_command $spotify_cmd
                elif [ $last = "mpd" ]
                then
                    mpc $1
                fi
            fi
        fi

    # only spotify is running
    elif $spotify_running
    then
        spotify_send_command $spotify_cmd
        echo spotify > $f
    # only mpd is running
    elif $mpd_running
    then
        if $mpd_controllable
        then
            mpc $1
            echo mpd > $f
        else
            >&2 echo "mpd is running put mpc is not available to control it!"
        fi
    fi
fi
