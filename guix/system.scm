(use-modules (gnu) (gnu system nss))
(use-service-modules 
	base
	desktop
	xorg
	networking
	dbus
	)

(use-package-modules
;;	base
	gcc
	python
	certs
	wm ;; i3
	conky
	suckless ;; dmenu
	text-editors ;; vis
	version-control ;; git
	shells ;; fish
	admin ;; htop
	file ;; file
	video
	gnupg
	ssh
	linux ;; alsa-utils
	)

(operating-system
	(host-name "fishbowl")
	(timezone "Europe/Berlin")
	(locale "en_US.UTF-8")
	
	(bootloader (grub-configuration (device "/dev/sda")))
	
	(mapped-devices
		(list (mapped-device
			(source (uuid "47c46f56-bdf9-4982-a00e-4aaf8f3b969f"))
			(target "the-root-device")
			(type luks-device-mapping))))

	(file-systems (cons*
		(file-system
			(device "root")
			(title 'label)
			(mount-point "/")
			(type "ext4")
			(dependencies mapped-devices))
		%base-file-systems))

	(swap-devices '("/swap"))

	(users (cons
		(user-account
			(name "fischerling")
			(comment "")
			(group "users")
			(supplementary-groups '("wheel" "netdev"
						"audio" "video"))
			(home-directory "/home/fischerling"))
		%base-user-accounts))

	(packages (cons*
		i3-wm i3status dmenu ;; Desktop
		
		gcc python-wrapper git ;; Devel
		fish fish-guix
		vis
		htop file
		gnupg pinentry
		openssh
		alsa-utils
		nss-certs               ;for HTTPS access
		%base-packages))

	(services (cons* 
		(console-keymap-service "de")

		(slim-service )
		
		(wicd-service)
		
		(dbus-service)
		(polkit-service)
		(upower-service)
		(udisks-service)
		(colord-service)
		(ntp-service)
		%base-services))

	;; Allow resolution of '.local' host names with mDNS.
	(name-service-switch %mdns-host-lookup-nss))
