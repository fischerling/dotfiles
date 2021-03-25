# set umask
umask 027

# PATH Stuff

for dir in /bin /sbin ~/.local/bin
	fish_add_path $dir
end

# export the path to our dotfiles
if not set -q DOTFILES_LOCATION
	set -x DOTFILES_LOCATION (get_dotfiles_location)
end

# include cargo binaries
if type -q rustup
    for p in $HOME/.rustup/toolchains/*/bin $HOME/.cargo/bin
        fish_add_path $p
    end
end

#include go binaries
if type -q go
	if not set -q GOPATH; and test -d ~/code/go
		set -x GOPATH ~/code/go

		if not contains $GOPATH/bin $PATH
			set PATH $GOPATH/bin $PATH
		end
	end
end

# TODO find a  better way to check if we are on guixsd
if type -q guix
	set -x GUIX_PACKAGE_PATH $DOTFILES_LOCATION/guix/packages
	# source the system paths
	set fish_function_path $fish_function_path /run/current-system/profile/share/fish/functions
	set fish_complete_path $fish_complete_path /run/current-system/profile/share/fish/completions
end

fish_add_path /bin/core_perl
fish_add_path /usr/local/bin

# autoload functions and completions in .dotfiles 
set fish_function_path $DOTFILES_LOCATION/config/fish/functions $fish_function_path
# add arch specific functions
if type -q pacman
	set fish_function_path $DOTFILES_LOCATION/arch-linux $fish_function_path
end
set fish_complete_path $DOTFILES_LOCATION/config/fish/completions $fish_complete_path

# add git-alias subdirectory to functions path
set fish_function_path $DOTFILES_LOCATION/config/fish/functions/git-alias $fish_function_path

set -x __fish_git_prompt_show_informative_status true

if not set -q EDITOR
	if type -q vis
		if not contains "$DOTFILES_LOCATION/config/vis/?.lua" $VIS_PATH
			set -x VIS_PATH "$DOTFILES_LOCATION/config/vis/?.lua" $VIS_PATH
		end
		set -x EDITOR vis
	else if type -q vim
		set -x EDITOR vim
	end
end

not set -q VISUAL; and set -q EDITOR; set -x VISUAL $EDITOR

not set -q SSH_KEY_PATH; and set -x SSH_KEY_PATH $HOME/.ssh/id_rsa
not set -q SSH_AUTH_SOCK; set -x SSH_AUTH_SOCK $HOME/.ssh/agent.sock

# set yaourt specific VARS
if type -q yaourt
    if not set -q AURUSEGIT
        set -x AURUSEGIT 1
    end
    if not set -q AURSHOWDIFF
        set -x AURSHOWDIFF 1
    end
end

set -x GPG_TTY (tty)

#start xsession if we are not in ssh
if not set -q SSH_CLIENT; or not set -q SSH_TTY
	if not set -q DISPLAY; and test "$XDG_VTNR" = "1"
		if type -q sway
			set -x TERMINAL termite
			set -x BROWSER qutebrowser
			mkdir -p ~/.local/share/sway
			sway -V ^ ~/.local/share/sway/log
		else
			startx ~/.xinitrc
		end
	end
else
	# display user in theme
	set -g theme_display_user yes
end

