(in-package #:cl-dsa)

(defun binary (num)
  (declare (type integer num))
  (loop
    :for divisor := num :then (floor (/ divisor 2))
    :until (<= divisor 0)
    :collect (digit-char (rem divisor 2)) :into bits
    :finally (return (coerce (reverse (if (zerop num) '(#\0) bits)) 'string))))
