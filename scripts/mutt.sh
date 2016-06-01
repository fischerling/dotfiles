#!/bin/sh

# read the password file
pwds=`gpg -d ~/.mutt/passwords`
eval "$pwds"
# execute mutt in a terminal if we are in a graphical session ( X or Wayland )
# and TERM is linux => this script was started not from a terminal 
if [ "$DISPLAY" ] || [ "$WAYLAND_DISPLAY" ] && [ "$TERM" == "linux" ]
then
    # change font size on my main laptop
    if [ "$(hostname)" = "fishtank" ]
    then
        exec urxvt -fn "xft: Terminess Powerline:pixelsize=18" -e "mutt"
    else
        exec urxvt -e "mutt"
    fi
else
    exec mutt "$@"
fi
