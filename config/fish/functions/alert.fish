function alert --description 'print and ring bell' --argument loop
	set usage "Usage: alert [-l | --loop]"
	set cmd "xkbbell ^/dev/null; echo -n -e \a"

	if test -n "$loop"; and test "$loop" != "-l" -a "$loop" != "--loop"; or test (count $argv) -gt 1
		echo $usage >&2
		return 1
	else
		eval $cmd
		if test -n "$loop"
			while true
				for i in (seq 1 20)
					alert
					sleep 1
					end
				sleep 1m
			end
		end
	end
end
