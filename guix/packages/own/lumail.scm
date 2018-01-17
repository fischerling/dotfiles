(define-module (own lumail)
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
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu))

(define-public lumail
  (package
    (name "lumail")
    (version "3.0")
    (source (origin
             (method git-fetch)
             (uri (git-reference
                     (url "git://github.com/lumail/lumail.git")
                     (commit "HEAD")))
             (sha256 (base32 "1c3f3i0ysqw21di9x4cwl8x6g05z84aj307rrxdmqv057ynmwyrv"))))
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
     "Lumail is a modern console-based email client with build in lua scripting support")
    (license gpl2)))

