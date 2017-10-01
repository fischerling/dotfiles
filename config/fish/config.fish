# PATH Stuff

if not contains ~/.local/bin $PATH
    set PATH ~/.local/bin $PATH
end

# export the path to our dotfiles
if not set -q DOTFILES_LOCATION
	set -x DOTFILES_LOCATION (get_dotfiles_location)
end

# include cargo binaries
if type -q rustup
    for p in $HOME/.rustup/toolchains/*/bin
        if not contains $p $PATH
            set PATH $PATH $p
        end
    end
end

#include go binaries
if type -q go
    not set -q GOPATH; and set -x GOPATH ~/Desktop/projects/go

	if not contains $GOPATH/bin $PATH
	    set PATH $GOPATH/bin $PATH
	end
end

# guixsd has nether /bin nor /usr
# TODO find a  better way to check if we are on guixsd
if type -q guix
	set -x GUIX_PACKAGE_PATH $DOTFILES_LOCATION/guix/packages
	# source the system paths
	set fish_function_path $fish_function_path /run/current-system/profile/share/fish/functions
	set fish_complete_path $fish_complete_path /run/current-system/profile/share/fish/completions
else
	if not contains /bin/core_perl $PATH
	    set PATH /bin/core_perl $PATH
	end

	if not contains /usr/local/bin $PATH
	    set PATH /usr/local/bin $PATH
	end
end

# autoload functions and completions in .dotfiles 
set fish_function_path $DOTFILES_LOCATION/config/fish/functions $fish_function_path
set fish_complete_path $DOTFILES_LOCATION/config/fish/completions $fish_complete_path

# add git-alias subdirectory to functions path
set fish_function_path $DOTFILES_LOCATION/config/fish/functions/git-alias $fish_function_path

set -x __fish_git_prompt_show_informative_status true

not set -q MPD_PORT; and set -x MPD_PORT 6601

if not set -q EDITOR
	if type -q vis
		set -x EDITOR vis
	else if type -q vim
		set -x EDITOR vim
	end
end

not set -q VISUAL; and set -q EDITOR; set -x VISUAL $EDITOR

not set -q SSH_KEY_PATH; and set -x SSH_KEY_PATH $HOME/.ssh/id_rsa

# start ssh-agent
if not pgrep ssh-agent >/dev/null
	not set -q SSH_AUTH_SOCK; set -x SSH_AUTH_SOCK ~/.ssh/agent.sock
	test -e $SSH_AUTH_SOCK; and rm $SSH_AUTH_SOCK
	set out (ssh-agent -a $SSH_AUTH_SOCK)
	set -U SSH_AGENT_PID (string replace ";" "" (string split " " $out)[-1])
end

# set yaourt specific VARS
if type -q yaourt
    if not set -q AURUSEGIT
        set -x AURUSEGIT 1
    end
    if not set -q AURSHOWDIFF
        set -x AURSHOWDIFF 1
    end
end

#start xsession
if not set -q DISPLAY; and test "$XDG_VTNR" = "1"
	startx ~/.xinitrc
end

