(defpackage #:cl-dsa
  (:use #:cl)
  (:export #:sieve-primes)
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

  ;; c-algorithms
  (:export
   ;; chapter 2
   #:euclid-gcd #:euclid-gcd-fast
   #:fraction #:make-fraction #:fraction-numerator #:fraction-denominator #:reduce-fraction
   #:convert-int
   #:binary
   #:gcd-triplet
   #:largest-pair-with-gcd-1))
