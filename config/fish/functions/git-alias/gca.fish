function gca --description "Alias for git commit -v -a" --wraps 'git add'
	git commit -v -a $argv;
end
