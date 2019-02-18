#TODO update dotfile directory

function upgrade -d "universal upgrade function"
	function is_command -a cmd -d "check if a command is available"
        type $cmd >/dev/null 2>/dev/null
    end

    function maybe_root -a cmd -d "execute a cmd if it fails try to use sudo"
        set res (eval $cmd 2>&1)
        # cmd failed
        if test $status -gt 0
            # try to guess cause
            if string match -r ".*root|permission.*" "$res"
               set s_cmd ""
               for c in (string split ";" $cmd)
                   set s_cmd $s_cmd (echo $c | sed -r "s/^ ?(and |or )?/\1sudo /" -)
               end
               eval (string join ";" $s_cmd)
            else
                echo "$res" >&2
                return $status
            end
        end
    end

    # Arch
    if is_command pacman
        if is_command yay
            yay -Syu
        else if is_command pacaur
            pacaur -Syu
        else if is_command yaourt
            yaourt -Syua
        else
            maybe_root "pacman -Syu"
        end
    end

    # Debian based
    if is_command apt-get
        if is_command apt
            maybe_root "apt update; and apt dist-upgrade"
        else
            maybe_root "apt-get update; and apt-get dist-upgrade"
        end
    end
end
