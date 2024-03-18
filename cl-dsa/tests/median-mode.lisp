(in-package #:cl-dsa/tests)

(in-suite* median-mode :in cl-dsa-tests)

(test median
  (is-true (null (median #())))
  (is-true (= (median #(1)) 1))
  (is-true (= (median #(1 2)) 1.5))
  (is-true (= (median #(2 5 8 4 9 6 7)) 6))
  (is-true (= (median #(17 2 7 27 15 5 14 8 10 24 48 10 8 7 18 28)) 12)))

(test mode
  (is-true (null (mode #())))
  (is-true (= (mode #(1)) 1))
  (is-true (null (mode #(1 2))))
  (is-true (= (mode #(1 1 2)) 1))
  (is-true (= (mode #(7 6 8 7 9 7 8 5 5 4 7 8 9)) 7)))
