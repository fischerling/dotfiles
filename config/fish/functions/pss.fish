function pss
	if test (count $argv) -ne 1
        echo "usage: pss PATTERN"
    else
       set pids (pgrep -d , -f $argv[1])
       if test -n $pids
           echo -ne "\033[1;32m"
           ps -Fp $pids
           echo -ne "\033[1;0m"
       end
    end
end
