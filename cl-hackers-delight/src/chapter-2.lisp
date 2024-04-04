(in-package #:cl-hackers-delight)

;;; This can be used to determine if an unsigned integer is a power of 2 or is 0
(defun turnoff-rightmost-1 (num)
  "Turns off the rightmost 1 bit, producing 0 if none. Formula: x & (x - 1)"
  (logand num (1- num)))

(defun turnon-rightmost-0 (num)
  "Turns on the rightmost 0 bit, producing all 1's if none. Formula: x | (x + 1)"
  (logior num (1+ num)))
