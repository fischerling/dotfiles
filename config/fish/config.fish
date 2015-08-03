# add git-alias subdirectory to functions path
set fish_function_path /home/fischerling/.config/fish/functions/git-alias $fish_function_path

if not set -q __fish_git_prompt_show_informative_status
    set -Ux __fish_git_prompt_show_informative_status true
end

if not set -q MPD_PORT
    set -Ux MPD_PORT 6601
end

if not set -q EDITOR
    set -Ux EDITOR vim
end

if not set -q SSH_KEY_PATH
    set -Ux SSH_KEY_PATH /home/fischerling/.ssh/rsa_id
end

if not contains /usr/local/bin $PATH
    set PATH $PATH /usr/local/bin
end
