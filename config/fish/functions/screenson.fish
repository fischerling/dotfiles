function screenson --description "enable xscreensaver and dpms"
	xset s on; xset +dpms; and echo 'xscreensaver and dpms enabled' $argv; 
end
