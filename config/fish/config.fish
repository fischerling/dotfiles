# add git-alias subdirectory to functions path
set fish_function_path /home/fischerling/.config/fish/functions/git-alias $fish_function_path

if not set -q __fish_git_prompt_show_informative_status
    set -Ux __fish_git_prompt_show_informative_status true
end
_
