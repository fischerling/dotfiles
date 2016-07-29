#!/bin/sh

sudo wpa_supplicant -B -iwlp2s0 -D wext -c /etc/wpa_supplicant/fau_stud.conf
sudo dhcpcd wlp2s0
