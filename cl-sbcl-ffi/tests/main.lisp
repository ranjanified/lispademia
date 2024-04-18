(defpackage #:cl-sbcl-ffi/tests
  (:use #:cl #:sb-alien
        #:cl-sbcl-ffi
	#:fiveam))

(in-package #:cl-sbcl-ffi/tests)

(def-suite cl-sbcl-ffi)

(def-suite c-algorithms :in cl-sbcl-ffi)

(defgeneric warmup-suite (suite))

(defun run-warmups ())

(defun run-tests ()
  (run-warmups)
  (run! 'cl-sbcl-ffi))

