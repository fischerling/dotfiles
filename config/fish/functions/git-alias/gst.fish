function gst --description "Alias for git status" --wraps 'git status'
	git status $argv;
end
