function upto --description 'go up in directory tree' --argument expr
	if test -z $expr
        echo "A directory expression must be provided." >&2
        return 1
    end
    if test $expr = "/"
        cd /
        return 0
    end
    set current_dir $PWD
    set matched_dir ""
    set matching true

    while test $matching = "true"
        if string match -q "*$expr*" $current_dir
            set matched_dir $current_dir
            set current_dir (dirname $current_dir)
        else
            set matching false
        end
    end
    if test -n $matched_dir
        cd $matched_dir
        return 0
    else
        echo "No match." >&2
        return 1
    end
end
