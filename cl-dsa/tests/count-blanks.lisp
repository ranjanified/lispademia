(in-package #:cl-dsa/tests)

(in-suite* blanks-counting :in cl-dsa)

(test count-blanks
  (is-true (zerop (count-blanks             "")))
  (is-true (zerop (count-blanks        "nalin")))
  (is-true (= 1 (count-blanks   "nalin ranjan")))
  (is-true (= 2 (count-blanks   "nalin ranjan "))))
