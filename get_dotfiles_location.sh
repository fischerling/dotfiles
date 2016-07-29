#!/bin/sh

# see:
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in

echo $(dirname "$(readlink -f "$0")")
