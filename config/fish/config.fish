# PATH Stuff

# include cargo binaries
if type -q multirust
    for p in $HOME/.multirust/toolchains/*/cargo/bin
        if not contains $p $PATH
            set PATH $PATH $p
        end
    end
end

#include go binaries
set -x GOPATH ~/Desktop/projects/go

if not contains $GOPATH/bin $PATH
    set PATH $GOPATH/bin $PATH
end

if not contains /bin/core_perl $PATH
    set PATH /bin/core_perl $PATH
end

if not contains ~/.local/bin $PATH
    set PATH ~/.local/bin $PATH 
end

if not contains /usr/local/bin $PATH
    set PATH /usr/local/bin $PATH 
end

# export the path to our dotfiles
set -x DOTFILES_LOCATION (get_dotfiles_location)

# autoload functions and completions in .dotfiles 
set fish_function_path $DOTFILES_LOCATION/config/fish/functions $fish_function_path
set fish_complete_path $DOTFILES_LOCATION/config/fish/completions $fish_complete_path


# add git-alias subdirectory to functions path
set fish_function_path $DOTFILES_LOCATION/config/fish/functions/git-alias $fish_function_path


set -x __fish_git_prompt_show_informative_status true

set -x MPD_PORT 6601

if type -q vis
set -x EDITOR vis
else
set -x EDITOR vim
end

set -x VISUAL $EDITOR

set -x BROWSER qutebrowser

set -x SSH_KEY_PATH $HOME/.ssh/rsa_id

# set yaourt specific VARS
if type -q yaourt
    if not set -q AURUSEGIT
        set -x AURUSEGIT 1
    end
    if not set -q AURSHOWDIFF
        set -x AURSHOWDIFF 1
    end
end

