#!/bin/sh

metadata=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata')
                                                                                
artist=$(echo "$metadata" | grep -A 2 -E "artist" | grep -v -E "artist" | grep -v -E "array" | cut -b 27- | cut -d  '"' -f 1 | grep -v -E ^$)
                                                                                        
title=$(echo "$metadata" | grep -A 1 -E "title" | grep -v -E "title" | cut -b 44- | cut -d '"' -f 1| grep -v -E ^$)

echo $artist - $title
