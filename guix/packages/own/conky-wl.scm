(define-module (own conky-wl)
    #:use-module (gnu packages conky)
    #:use-module (gnu packages linux) ;wireless-tools
    #:use-module (guix packages)
    #:use-module (guix utils))

(define-public conky-wl
    (package
        (inherit conky)
        (name "conky-wl")
        (synopsis "conky with wireless support" )
	(inputs `(
         ("wireless-tools" ,wireless-tools)
         ,@(package-inputs conky)))
        (arguments
	 (substitute-keyword-arguments (package-arguments conky)
          ((#:configure-flags cf) `(cons "-DBUILD_WLAN=true" ,cf))))))
