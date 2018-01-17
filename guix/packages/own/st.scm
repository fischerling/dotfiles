(define-module (own st)
    #:use-module (gnu packages suckless)
    #:use-module (guix gexp)
    #:use-module (guix packages)
)

(define-public own-st
    (package
        (inherit st)
        (name "own-st")
        (synopsis "st with my pathes")
        (source
            (local-file
                "/home/fischerling/.dotfiles/st"
                #:recursive? #t))))
