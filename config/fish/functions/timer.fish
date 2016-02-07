function timer

	set usage "Usage: timer [-q] <minutes to wait>"

	if test (count $argv) -lt 1
        echo $usage
        return 1
    end

    for i in (seq 1 (count $argv))
        if test $argv[$i] = "-q"
            set quiet 1
        else if test $argv[$i] -gt 0
            set time $argv[$i]
        else
            echo $usage
            return 1
        end
    end

    if not set -q time
        echo $usage
        return 1
    end

	for i in (seq 1 $time)
        sleep 1m
        echo (string replace -r '0m left' ready! (echo (math $argv[1] - $i)m left))
    end
    if not set -q quiet
        while true
            for i in (seq 1 20)
                xkbbell
                sleep 1
            end
            sleep 1m
        end
    end
end
