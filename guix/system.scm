(use-modules (gnu) (gnu system nss))
(use-service-modules desktop)
(use-package-modules base wm certs text-editors version-control shells admin file xorg video gnupg ssh linux)

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

  (file-systems (cons* (file-system
                        (device "root")
                        (title 'label)
                        (mount-point "/")
                        (type "ext4")
                        (dependencies mapped-devices))
                      %base-file-systems))
  (swap-devices '("/swap"))

  (users (cons (user-account
                (name "fischerling")
                (comment "")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"))
                (home-directory "/home/fischerling"))
                ;;(shell "fish"))
               %base-user-accounts))

  (packages (cons* i3-wm                   ;window managers
                   git
                   fish
                   wpa-supplicant
                   acpi
                   file
                   vis
                   htop
                   gnupg
                   openssh
                   xorg-server
                   xinit
                   mpv
                   youtube-dl
                   nss-certs               ;for HTTPS access
                   %base-packages))

  (services (cons* (console-keymap-service "de")
                   %base-services))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
