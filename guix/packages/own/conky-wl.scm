(define-module (own conky-wl)
    #:use-module (gnu packages conky)    ; emacs
    #:use-module (guix build-system cmake) ; gnu-build
    #:use-module (guix packages))         ; package

(define-public conky-wl
    (package
        (inherit conky)
        (name "conky-wl")
        (synopsis "conky with wireless support" )
        (build-system cmake-build-system)
        (arguments `(
            #:configure-flags '("-DBUILD_WLAN=true")
            ,@(package-arguments conky)))))
