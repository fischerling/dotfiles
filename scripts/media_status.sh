#!/bin/bash
mpd_running=$(mpc | grep "\[playing\]")

if pgrep spotify &>/dev/null
then
    if type pacmd &>/dev/null
    then
        output=$(pacmd list-sink-inputs)
        state=""
        spotify_running=false

        while read -r line; do
            if [[ $line == *state* ]]
            then
                if [[ $line == *RUNNING* ]]
                then
                    state="RUNNING" 
                else
                    state=""
                fi
            fi

            if [[ $line == *application.name* ]]
            then
                if [[ $state == "RUNNING" ]] && [[ $line == *Spotify* ]]
                then
                    spotify_running=true
                    break
                fi
            fi
        done <<< "$output"
    elif lsof | grep /dev/snd | grep spotify &>/dev/null
    then
        spotify_running=true
    fi

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
