function timer
	if test (count $argv) -ne 1
        echo "Usage: timer <minutes to wait>"
        return
    end
	for i in (seq 1 $argv[1])
        sleep 1m
        echo (string replace -r '^0$' ready! (math $argv[1] - $i))m left
    end
    while true
        for i in (seq 1 20)
            xkbbell
            sleep 1
        end
        sleep 1m
    end
end
