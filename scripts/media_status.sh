#!/bin/bash
mpd_running=$(mpc 2>/dev/null | grep "\[playing\]")
spotify_running=$(./media_is_spotify_playing.sh)

if pgrep spotify &>/dev/null
then
    if $spotify_running && [[ $mpd_running != "" ]]
    then
        echo spotify and mpd running
    else
        metadata=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata')

        if [[ $metadata == *"spotify:ad"* ]]
        then
            echo "Spotify: ad :/"
        else
            artist=$(echo "$metadata" | egrep -A 2 "artist" | egrep -v "artist" | egrep -v "array" | cut -b 27- | cut -d '"' -f 1 | egrep -v ^$)

            title=$(echo "$metadata" | egrep -A 1 "title" | egrep -v "title" | cut -b 44- | cut -d '"' -f 1| egrep -v ^$)

            if $spotify_running
            then
                pb_status="▶"
            else
                pb_status="▐▐"
            fi
            
            echo Spotify: $pb_status $artist - $title
        fi
    fi
elif pgrep mpd &>/dev/null
then
    if type mpc &>/dev/null
    then
        if [[ $mpd_running != "" ]]
        then
            pb_status="▶"
        else
            pb_status="▐▐"
        fi
        echo MPD: $pb_status $(mpc current)
    else
        echo "for mpd status mpc is needed"
    fi
else
    echo no music
fi
