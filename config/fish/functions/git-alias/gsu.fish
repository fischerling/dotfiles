function gsu --description "Alias for git submodule update" --wraps 'git submodule update'
	git submodule update $argv;
end
