function screensoff --description "disable xscreensaver and dpms"
	xset s off; xset -dpms; and echo 'xcreensaver and dpms disabled' $argv; 
end
