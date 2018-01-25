function list_newest_packages --description "list all packages sorted by install date old->new"
	if type -q expac
		expac --timefmt=%s '%b\t%n' | sort -n
	else
		echo "expac not available!"
	end
end
