#!/bin/sh

if type pamixer &> /dev/null
then
    command_inc="pamixer -i "
    command_dec="pamixer -d "
    command_toggle="pamixer -t"
elif type amixer &> /dev/null
then
    command_inc="amixer -q set Master "
    inc_suff="%+"
    command_dec="amixer -q set Master "
    dec_suff="%-"
    command_toggle="amixer -q set Master toggle"
else
    command_inc="i3-nagbar -m \"please install amixer(ALSA) or pamixer(PA)\""
    command_dec="i3-nagbar -m \"please install amixer(ALSA) or pamixer(PA)\""
    command_toggle="i3-nagbar -m \"please install amixer(ALSA) or pamixer(PA)\""
fi

if [[ $1 =~ ^\+[0-9]$ ]]
then
    eval $command_inc "${1:1}$inc_suff"
elif [[ $1 =~ ^\-[0-9]$ ]] 
then
    eval $command_dec "${1:1}$dec_suff"
elif [[ $1 = "toggle" ]] 
then
    eval $command_toggle
else
    eval "i3-nagbar -m \"not supported command $1\""
fi
