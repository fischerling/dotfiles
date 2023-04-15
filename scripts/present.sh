#!/bin/bash

if [ "$1" = "mirror" ]; then
	swaymsg "workspace P"
	"${DOTFILES_LOCATION}"/scripts/sway-toolwait -w at.yrlf.wl_mirror wl-mirror eDP-1
	swaymsg "fullscreen"
elif [ -f "$1" ]; then
	"${DOTFILES_LOCATION}"/scripts/sway-toolwait pdfpc "$1"
	swaymsg "[title=\"pdfpc - presentation ()\"] focus" && \
		swaymsg "move window to workspace P" && \
		swaymsg "workspace P" && \
		swaymsg "[title=\"pdfpc - presenter ()\"] focus"
fi
