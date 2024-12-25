function gl --description "Alias for git pull" --wraps 'git pull'
	git pull $argv;
end
