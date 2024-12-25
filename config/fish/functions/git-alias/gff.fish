function gff --description "Alias for git diff" --wraps 'git diff'
	git diff $argv;
end
