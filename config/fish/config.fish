# autoload functions and completions in .dotfiles 
set fish_function_path $HOME/.dotfiles/config/fish/functions $fish_function_path
set fish_complete_path $HOME/.dotfiles/config/fish/completions $fish_complete_path


# add git-alias subdirectory to functions path
set fish_function_path $HOME/.dotfiles/config/fish/functions/git-alias $fish_function_path

# include cargo binaries
if type -q multirust
    for p in $HOME/.multirust/toolchains/*/cargo/bin
        if not contains $p $PATH
            set PATH $PATH $p
        end
    end
end

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

if not contains /usr/local/bin $PATH
    set PATH $PATH /usr/local/bin
end
