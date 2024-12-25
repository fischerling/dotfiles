function gp --description "Alias for git push" --wraps 'git push'
	git push $argv;
end
