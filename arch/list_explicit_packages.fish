function list_explicit_installed_packages -d ""
	begin; pacman -Qeq; cat /var/log/pacman.log; end | awk '
	NF == 1 { pkgs[$0] = 1; }
	$4 == "installed" {
	if ($5 in pkgs) { pkgs[$5] = $1 " " $2; }
	}
	END {
	for (p in pkgs) { print pkgs[p], p; }
	}' | sort
end
