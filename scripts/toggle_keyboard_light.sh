#!/bin/sh
light_dev=sysfs/leds/white:kbd_backlight

if [ "$(light -s $light_dev)" = "100.00" ]; then
	light -s $light_dev -S 0
else
	light -s $light_dev -S 100
fi
