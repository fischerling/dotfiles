#!/bin/bash

if type fish &>/dev/null
then
    exec fish $1
else
    exec i3-nagbar -m "please install fish to use this script $1" 
fi
