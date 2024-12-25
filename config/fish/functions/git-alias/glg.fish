function glg --description "Alias for git log --stat --color" --wraps 'git log'
	git log --stat --color $argv;
end
