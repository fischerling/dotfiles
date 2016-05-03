function cdb --description 'go n direcotrys back' --argument count
	for i in (seq 1 $count)
        cd ..
    end
end
