#!/bin/bash

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

exec i3 -V > ~/.i3/log