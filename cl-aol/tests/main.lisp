(defpackage cl-aol/tests/main
  (:use :cl
        :cl-aol
        :fiveam))

;; NOTE: To run this test file, execute `(asdf:test-system :cl-aol)' in your Lisp.

(in-package :cl-aol/tests/main)

(def-suite cl-aol)
