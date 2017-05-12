#!/bin/sh
mpd_playing=$(mpc 2>/dev/null | grep "\[playing\]")
spotify_playing=$($DOTFILES_LOCATION/scripts/media_is_spotify_playing.sh)

if [[ $spotify_playing == "true" ]] 
then
    if [[ $mpd_playing != "" ]]
    then
        echo spotify and mpd playing
    else
        pb_status=""

        if [[ $metadata == *"spotify:ad"* ]]
        then
            echo "Spotify: ad :/"
        else
            echo Spotify: "▶" $($DOTFILES_LOCATION/scripts/media_print_spotify_info.sh)
        fi
    fi
elif [[ $mpd_playing != "" ]]
then
    if type mpc &>/dev/null
    then
        echo MPD: "▶" $(mpc current)
    else
        echo "for mpd status mpc is needed"
    fi
elif pgrep spotify &>/dev/null
then
    echo Spotify: "▐▐" $($DOTFILES_LOCATION/scripts/media_print_spotify_info.sh)
elif pgrep mpd &>/dev/null
then
    if type mpc &>/dev/null
    then
        echo MPD: "▐▐" $(mpc current)
    else
        echo "for mpd status mpc is needed"
    fi
else
    echo no music
fi
