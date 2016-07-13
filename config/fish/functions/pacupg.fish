function pacupg --description 'Alias for pacaur -Syua'
    if type pacaur 1>/dev/null 2>/dev/null
	    pacaur -Syu $argv; 
    else
        echo "pacaur not installed"
    end
end
