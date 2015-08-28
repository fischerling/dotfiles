function isrunning --description 'alias for ps -A | grep'
	ps -A | grep $argv;
end
