#!/bin/bash

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

[ ! -d ~/.local/share/i3 ] && mkdir -p ~/.local/share/i3
exec i3 -V > ~/.local/share/i3/log
