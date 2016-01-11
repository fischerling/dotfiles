#!/bin/bash

STATE=`synclient -l | grep TouchpadOff | awk '{ print $3 }'`;

if [ "$STATE" == "0" ]; then
synclient TouchpadOff=1; else
synclient TouchpadOff=0 
fi


# Forces break of touchpad functions while typing
# 1 second follow interval.
if [ "$STATE" == "1" ]; then
syndaemon -i 1 -d; else
killall syndaemon
fi
