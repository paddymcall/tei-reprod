(define-module (manifest)
  #:use-module  (gnu packages search)
  #:use-module  (gnu packages)
  #:use-module  (guix download)
  #:use-module  (guix packages)
  #:use-module  (guix profiles))

;; Check here: https://oligarchy.co.uk/xapian/master/
(define xapian-latest "1.5.0_git3747")

(define-public xapian-devel
  (package
   (inherit xapian)
   (name "xapian-devel")
   (version xapian-latest)
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://oligarchy.co.uk/xapian/master/"
			 "xapian-core-"
			 version
			 ".tar.xz"))
     (sha256
      (base32 "199w00a4ihain9mrj7imdp0slyf8aa76d5kmh9wfq17v1fhccal9"))))
   (arguments
    `(#:phases
      (modify-phases %standard-phases
		     ;; Ignore all tests!
		     (replace 'check (lambda _ #t)))))))

;; We can collect manifests from different places: specifications
;; (simple labels), packages defined here or elsewhere, and from other
;; manifest files too:
(concatenate-manifests
 `(,(specifications->manifest
     '("bash-minimal"
       "guile" "guile-readline" "guile-gcrypt" "guile-json"))
   ,(packages->manifest (list xapian-devel))
   ,(load "../manifest.scm")))
