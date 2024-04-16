(in-package #:cl-sbcl-ffi)

(define-alien-routine "euclid_gcd" unsigned-int (num1 unsigned-long) (num2 unsigned-long))
