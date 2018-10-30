#!/bin/bash

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Overwrite Capslock with escape
xmodmap -e "clear lock"
xmodmap -e "keycode 66 = Escape NoSymbol Escape"

[ ! -d ~/.local/share/i3 ] && mkdir -p ~/.local/share/i3
exec i3 -V > ~/.local/share/i3/log
