function gcm --description "Alias for git commit -m" --wraps 'git commit'
	git commit -m $argv;
end
