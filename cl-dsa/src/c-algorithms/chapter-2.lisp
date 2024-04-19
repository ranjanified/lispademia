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
  ;; gcd of any 2 consecutive numbers is 1
  (list most-positive-fixnum (1- most-positive-fixnum)))
