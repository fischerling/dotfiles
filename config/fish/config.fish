# autoload functions and completions in .dotfiles 
set fish_function_path $HOME/.dotfiles/config/fish/functions $fish_function_path
set fish_completion_path $HOME/.dotfiles/config/fish/completions $fish_completion_path


# add git-alias subdirectory to functions path
set fish_function_path $HOME/.dotfiles/config/fish/functions/git-alias $fish_function_path

# include wd
set fish_function_path $HOME/.dotfiles/config/fish/wd/functions $fish_function_path
set fish_complete_path $HOME/.dotfiles/config/fish/wd/completions $fish_complete_path

# include mark
set fish_function_path $HOME/.dotfiles/config/fish/mark/functions $fish_function_path
set fish_complete_path $HOME/.dotfiles/config/fish/mark/completions $fish_complete_path

# include fink
set fish_function_path $HOME/.dotfiles/config/fish/fink/functions $fish_function_path
set fish_complete_path $HOME/.dotfiles/config/fish/fink/completions $fish_complete_path

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
