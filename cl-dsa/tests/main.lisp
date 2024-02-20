(defpackage cl-dsa/tests
  (:use :cl
        :cl-dsa
        :fiveam))
(in-package :cl-dsa/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-dsa)' in your Lisp.

(test test-target-1
  (is-true "should (= 1 1) to be true"))
