(in-package #:cl-dsa)

(defun gcd-triplet (a b c)
  (declare (type (integer 0 *) a b c))
  (euclid-gcd (euclid-gcd a b) c))

(defun binary (num)
  (declare (type integer num))
  (loop
    :for divisor := num :then (floor (/ divisor 2))
    :until (<= divisor 0)
    :collect (digit-char (rem divisor 2)) :into bits
    :finally (return (coerce (reverse (if (zerop num) '(#\0) bits)) 'string))))

(defun largest-pair-with-gcd-1 ()
  (loop
    :for number-1 := most-positive-fixnum :then (1- number-1)
    :for number-2 := (1- number-1)        :then (1- number-2)
    :for gcd := (euclid-gcd-fast number-1 number-2)
    :while (> gcd 1)
    :until (> number-2 0)
    :finally (return (vector number-1 number-2))))
