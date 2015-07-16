function yaupg --description 'Alias for yaourt -Syua'
    if type yaourt 1>/dev/null 2>/dev/null
	    yaourt -Syua $argv; 
    else
        echo "yaourt not installed"
    end
end
