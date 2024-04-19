(defpackage #:cl-dsa
  (:use #:cl)
  (:export #:print-histogram-vertical)
  (:export #:count-blanks)
  ;; (:export #:word-count)

  (:export #:strlen)
  (:export #:strpos)
  (:export #:strcat)
  (:export #:substr)

  (:export #:median)
  (:export #:mode)

  (:export #:weather-report)

  (:export #:print-department-sales)

  (:export #:make-chess-board)
  (:export #:print-chess-board)

  (:export #:euclid-gcd #:fraction #:make-fraction #:fraction-numerator #:fraction-denominator #:reduce-fraction)

  ;; c-algorithms
  (:export
   ;; chapter 1
   #:convert-int
   #:binary
   ))
