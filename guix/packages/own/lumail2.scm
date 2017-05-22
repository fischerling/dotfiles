(define-module (own  lumail2)
  #:use-module (gnu packages mail) ; gmime
  #:use-module (gnu packages glib) ; gmime
  #:use-module (gnu packages lua)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pkg-config)
  #:use-module ((guix licenses)
                #:select (gpl2))
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu))

(define-public lumail2
  (package
    (name "lumail2")
    (version "3.0")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/lumail/lumail2/archive/release-"
                                  version ".tar.gz"))
             (sha256
              (base32
               "19947l3hg67b3i8dr1b3z0sl6qs8bb1zkxyilld65g8imqv6iq8w"))))
    (build-system gnu-build-system)
    (native-inputs
     `(("git" ,git)
       ("pkg-config" ,pkg-config)))
    (inputs
     `(("gmime" ,gmime)
       ("glib" ,glib)
       ("lua" ,lua-5.2)
       ("perl" ,perl)
       ("ncurses" ,ncurses)))
    (arguments
     `(#:tests? #f
       #:make-flags (list
                     (string-append "PREFIX=" %output))
       #:phases (modify-phases %standard-phases (delete 'configure))))
    (home-page "https://lumail.org/")
    (synopsis "Mail client")
    (description
     "Lumail2 is a modern console-based email client with build in lua scripting support")
    (license gpl2)))

