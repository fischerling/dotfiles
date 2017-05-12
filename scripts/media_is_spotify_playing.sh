#!/bin/sh

# this script returns 0 if spotify is playing 1 otherwise

# spotify's dbus interface is able to tell us it PlaybackStatus :)

status=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
/org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get \
string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' 2> /dev/null`

if [ $? -ne 0 ]
then
    echo false
    exit 1
fi

status=$(echo $status | grep -o -e \".*\" | cut -d \" -f 2)

if [ $status != "Playing" ]
then
    echo false
    exit 1
fi

echo true

#spotify_running=false

#if pgrep spotify &>/dev/null
#then
    #if type pacmd &>/dev/null
    #then
        #output=$(pacmd list-sink-inputs)
        #state=""
        #spotify_running=false

        #while read -r line; do
            #if [[ $line == *state* ]]
            #then
                #if [[ $line == *RUNNING* ]]
                #then
                    #state="RUNNING"
                #else
                    #state=""
                #fi
            #fi

            #if [[ $line == *application.name* ]]
            #then
                #if [[ $state == "RUNNING" ]] && [[ $line == *Spotify* ]]
                #then
                    #spotify_running=true
                    #break
                #fi
            #fi
        #done <<< "$output"
    #elif lsof | grep /dev/snd | grep spotify &>/dev/null
    #then
        #spotify_running=true
    #fi
#fi

#echo $spotify_running
#if [[ $spotify_running == "true" ]]
#then
    #exit 0
#else
    #exit 1
#fi
