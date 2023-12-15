(defpackage cl-aoc/tests/main
  (:use :cl
        :cl-aoc
        :fiveam))

(in-package :cl-aoc/tests/main)

(def-suite cl-aoc)
(def-suite aoc-2023 :in cl-aoc)
;; NOTE: To run this test file, execute `(asdf:test-system :cl-aoc)' in your Lisp.
