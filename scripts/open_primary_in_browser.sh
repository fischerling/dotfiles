#!/bin/bash

PRIMARY=""

if [[ ! -z "$WAYLAND_DISPLAY" ]]
then
	PRIMARY=$(wl-paste -p)
else
	PRIMARY=$(xclip -o -selection primary)
fi

eval $BROWSER "$PRIMARY"
