function pp --description 'safely execute content from the clipboard'
	# fish version of https://github.com/Aaronmsv/PastejackingProtection
    
    if not type -q xclip
        echo please install xclip
        return
    end

	set script (xclip -o)
    echo "$script" | cat -A
    echo  -e "\nExecute? (y/N): "
    read execute

    if test "$execute" = "y"
        eval $script
    end
end
