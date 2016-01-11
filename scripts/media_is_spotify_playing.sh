#!/bin/bash

spotify_running=false

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
fi

echo $spotify_running
if [[ $spotify_running == "true" ]]
then
    exit 0
else
    exit 1
fi
