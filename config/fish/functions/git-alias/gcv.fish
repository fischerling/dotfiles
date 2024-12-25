function gcv --description "Alias for git commit -v" --wraps 'git commit'
	git commit -v $argv;
end
