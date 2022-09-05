function pp --description 'safely execute content from the clipboard'
	# fish version of https://github.com/Aaronmsv/PastejackingProtection

	if set -q WAYLAND_DISPLAY
		set -f clip_cmd wl-paste
	else if set -q DISPLAY
		set -f clip_cmd "xclip -o"
	else
		echo "No graphical session detected" >&2
		return 1
	end

	set -f clip_exe (string split -f 1 " " $clip_cmd)
	if not type -q (string split -f 1 " " $clip_exe)
		echo "please install $clip_exe" >&2
		return 1
	end

	set -f script ($clip_cmd)
	echo "$script" | cat -A
	echo -e "\nExecute? (y/N): "
	read execute

	if test "$execute" = "y"
		eval $script
	end
end
