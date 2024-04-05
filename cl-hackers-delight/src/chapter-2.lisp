(in-package #:cl-hackers-delight)

;;; This can be used to determine if an unsigned integer is a power of 2 or is 0
(defun turnoff-rightmost-1 (num)
  "Turns off the rightmost 1 bit, producing 0 if none. Formula: x & (x - 1)"
  (logand num (1- num)))

(defun turnon-rightmost-0 (num)
  "Turns on the rightmost 0 bit, producing all 1's if none. Formula: x | (x + 1)"
  (logior num (1+ num)))

;;; This can be used to determine if an unassigned integer is of the form 2^n - 1, 0, or all 1's
(defun turnoff-trailing-1s (num)
  "Turns off trailing 1's in a word, producing num if none"
  (logand num (1+ num)))

(defun turnon-trailing-0s (num)
  "Turns on the trailing 0's in a word, producing num if none"
  (logior num (1- num)))

(defun word-with-only-1-bit-in-rightmost-0-bit-position (word)
  "Create a word with single 1-bit, at the position of the rightmost 0-bit in word, producing all 0's if none"
  ;; cl standard: (boole boole-andc1 word (1+ word)) achieves the same
  (logand (lognot word) (1+ word)))

(defun word-with-only-0-bit-in-rightmost-1-bit-position (word)
  "Create a word with single 0-bit, at the position of the rightmost 1-bit in word, producing all 1's if none"
  ;; cl standard: (boole boole-orc1 word (1- word)) achieves the same
  (logior (lognot word) (1- word)))
