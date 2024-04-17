(in-package #:cl-dsa/tests)

(in-suite* c-algorithms :in cl-dsa-tests)

(test euclid-gcd
  (is-true (zerop (euclid-gcd 0 0)))
  (is-true (=     (euclid-gcd 3 0) 3))
  (is-true (=     (euclid-gcd 0 3) 3))
  (is-true (=     (euclid-gcd 17 5) 1))
  (is-true (=     (euclid-gcd 6 18) 6)))
