# export the path to our dotfiles
if not set -q $DOTFILES_LOCATION
    set -Ux DOTFILES_LOCATION (get_dotfiles_location)
end


# autoload functions and completions in .dotfiles 
set fish_function_path $DOTFILES_LOCATION/config/fish/functions $fish_function_path
set fish_complete_path $DOTFILES_LOCATION/config/fish/completions $fish_complete_path


# add git-alias subdirectory to functions path
set fish_function_path $DOTFILES_LOCATION/config/fish/functions/git-alias $fish_function_path


if not set -q __fish_git_prompt_show_informative_status
    set -Ux __fish_git_prompt_show_informative_status true
end

if not set -q MPD_PORT
    set -Ux MPD_PORT 6601
end

if not set -q EDITOR
    set -Ux EDITOR vim
end

if not set -q BROWSER
    set -Ux BROWSER qutebrowser
end

if not set -q SSH_KEY_PATH
    set -Ux SSH_KEY_PATH $HOME/.ssh/rsa_id
end

# set yaourt specific VARS
if type -q yaourt
    if not set -q AURUSEGIT
        set -Ux AURUSEGIT 1
    end
    if not set -q AURSHOWDIFF
        set -Ux AURSHOWDIFF 1
    end
end

# PATH Stuff

# include cargo binaries
if type -q multirust
    for p in $HOME/.multirust/toolchains/*/cargo/bin
        if not contains $p $PATH
            set PATH $PATH $p
        end
    end
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
