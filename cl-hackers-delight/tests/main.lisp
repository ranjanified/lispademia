(defpackage #:cl-hackers-delight/tests
  (:use #:cl
        #:cl-hackers-delight
        #:fiveam))
(in-package :cl-hackers-delight/tests)

(def-suite cl-hackers-delight)

(defgeneric setup-suite (suite))
(defgeneric run-suite ())

(defun run-suite-setups ()
  (format t "run-suite-setup: ~a~&" 'cl-hackers-delight))

(defun run-suites ()
  (run! 'cl-hackers-delight))

(defun run-tests ()
  (run-suite-setups)
  (run-suites))
