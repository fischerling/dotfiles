(define-module (own conky-wl)
    #:use-module (gnu packages conky)
    #:use-module (guix build-system cmake)
    #:use-module (guix packages))

(define-public conky-wl
    (package
        (inherit conky)
        (name "conky-wl")
        (synopsis "conky with wireless support" )
        (build-system cmake-build-system)
        (arguments `(
            #:configure-flags '("-DBUILD_WLAN=true")
            ,@(package-arguments conky)))))
