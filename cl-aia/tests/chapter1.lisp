(defpackage :cl-aia/tests/chapter1
  (:use :cl :cl-aia :fiveam))

(in-package :cl-aia/tests/chapter1)

(test 1-1
  (is-true (string= (1-1) "slime in emacs with sbcl")))

(test 1-2
  (is-true (string= (1-2) "enter (exit) on repl, and evaluate")))

(test 1-3
  (is-true (string= (1-3) "CL-USER> ")))
