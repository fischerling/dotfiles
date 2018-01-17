#TODO update dotfile directory

function upgrade -d "universal upgrade function"
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
    if type -q pacman
        if type -q pacaur
            pacaur -Syu
        else if type -q yaourt
            yaourt -Syua
        else
            maybe_root "pacman -Syu"
        end
    end

    # Debian based
    if type -q apt-get
        if type -q apt
            maybe_root "apt update; and apt dist-upgrade"
        else
            maybe_root "apt-get update; and apt-get dist-upgrade"
        end
    end

    #GUIX SD
    if type -q guix
    	sudo bash -c "guix pull && guix system reconfigure --fallback /etc/guix/system.scm"
    	rm ~/.config/guix/latest
    	pushd ~/.config/guix
    	ln -s (realpath /root/.config/guix/latest) latest
    	popd
    	guix package -u
    end
end
