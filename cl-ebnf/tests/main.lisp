(defpackage #:cl-ebnf/tests
  (:use #:cl
        #:cl-ebnf
        #:fiveam))

(in-package #:cl-ebnf/tests)

(def-suite cl-ebnf-tests)

(defgeneric setup-suite (suite))
(defgeneric run-suite ())

(defun run-suite-setups ()
  (format t "run-suite-setup: ~a~&" 'cl-ebnf-tests))

(defun run-suites ()
  (run! 'cl-ebnf-tests))

(defun run-tests ()
  (run-suite-setups)
  (run-suites))
