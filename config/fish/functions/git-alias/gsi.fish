function gsi --description "Alias for git submodule init" --wraps 'git submodule init'
	git submodule init $argv;
end
