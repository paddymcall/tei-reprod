(use-modules
 ((guix licenses) #:prefix license:)
 (gnu packages autotools)
 (gnu packages base)
 (gnu packages bash)
 (gnu packages guile)
 ;; (gnu packages guile-xyz)
 (gnu packages haskell-xyz)
 (gnu packages parallel)
 (gnu packages pkg-config)
 (gnu packages texinfo)
 (gnu packages version-control)
 (gnu packages xml)
 (guix build-system gnu)
 (guix build-system haskell)
 (guix download)
 ;; (guix gexp)
 (guix packages)
 ;; (srfi srfi-1)
 ;; (gnu packages gawk)
 ;; (gnu packages less)
 ;; (gnu packages tex)
 )

(define glibc-locales-vegest
  ;; TODO: ‘export LANG=en_US.UTF-8
  ;; LOCPATH=${GUIX_ENVIRONMENT}/lib/locale/2.39’ to make unicode
  ;; things work
  (make-glibc-utf8-locales
   glibc
   #:locales (list "en_US" "de_DE" "bo_CN" "sa_IN")
   #:name "glibc-utf8-locales-en-de-bo-sa"))

(define-public ghc-citeproc-executable
  (package (inherit ghc-citeproc)
    (name "ghc-citeproc-exec")
    (version "0.8.1")
    (build-system haskell-build-system)
    (arguments
     `(#:configure-flags (list "--flags=executable")))))

(define stei-required-packages
  (list
   gnu-make
   bash
   coreutils
   findutils
   grep
   git
   ;; sed
   ;; gawk
   ;; less
   parallel
   pandoc
   ;; glibc-locales-vegest
   ;; ghc-citeproc-executable
   libxml2
   guile-3.0-latest
   guile-git
   guile-json-4
   guile-readline))

(define-public guile-stei
  ;; See https://guix.gnu.org/manual/en/html_node/package-Reference.html
  (package
   (name "guile-stei")
   (version "0.3.6")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://rdorte.org/pma/guile-stei-"
				version
                                ".tar.gz"))
            (sha256 ;; get this with guix download ....tar.gz
             (base32
              "18b1f87slh1x9qpxsfp0h4f1pprgkjqqycvqk7wm163jrfmd62xf"))))
   (build-system gnu-build-system)
   ;; native-inputs: for the build process (architecture build machine)
   (native-inputs
    (list autoconf automake pkg-config texinfo))
   ;; inputs: for the build process (architecture target machine)
   (inputs stei-required-packages)
   ;; propagated-inputs:
   (propagated-inputs stei-required-packages)
   (arguments
    `(#:tests? #f
               #:phases
               (modify-phases
                %standard-phases
                (add-after 'install 'symlink-stuff
			   (lambda* (#:key outputs #:allow-other-keys)
			     (let* ((out (assoc-ref outputs "out"))
				    (source-dir (string-append out "/share/guile/site/3.0/stei"))
				    (target-dir (string-append out "/bin")))
                               (mkdir-p target-dir)
                               #!
                               (format (current-warning-port)
                                       "Outputs: ~A; \n Out: ~A; \n source-dir: ~A; \n target-dir: ~A; \n files in source-dir: ~A; "
                                       outputs out source-dir target-dir
                                       (find-files out)
                                       ;; (find-files target-dir)
                                       )
                               !#
                               (for-each
				(lambda (x)
				  (symlink (string-append source-dir "/" x)
					   (string-append target-dir "/" x))
				  (chmod (string-append target-dir "/" x) #o755))
				'("run-conversions.scm"))
                               ))))))
   (native-search-paths
    (list (search-path-specification
           (variable "LOCPATH")
           (files (list "lib/locale/2.39")))
          (search-path-specification
           (variable "JAVA_HOME")
           (files (list "./")))))
   (synopsis "Software collection to use VEGEST schemas")
   (description "VEGEST — Vienna Encoding Guidelines for Editing Sanskrit Texts — is the name of the IKGA’s (https://www.oeaw.ac.at/ikga) effort to develop a set of guidelines for editing works produced in the tradition of Sanskrit literary culture. These guidelines come with a versatile software toolkit that facilitates the integration of the VEGEST standard into running editorial projects and the production of high-quality publications from the encoded texts.")
   (home-page "https://gitlab.oeaw.ac.at/vegest/vegest-lib/")
   (license license:gpl3+)))

(concatenate-manifests
   `(,(specifications->manifest
       '("bash-minimal"
	 "git"
	 "pandoc"
	 "libxml2"
	 "guile"
	 "guile-readline"
	 "guile-gcrypt"
	 "guile-json"))
     ,(packages->manifest
       (list glibc-locales-vegest
	     ghc-citeproc-executable
	     guile-stei))))
