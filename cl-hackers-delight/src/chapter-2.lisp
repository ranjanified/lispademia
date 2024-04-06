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

(defun word-with-1s-at-tailing-0s-and-0s-elsewhere (word)
  "Create a word with 1's at the positions of the trailing 0's in word, and 0's elsewhere, producing 0 if none"
  ;; (lognot (logior word (- word)) ; this one, or
  ;; (1- (logand word (- word)) ; this one, or
  ;; cl standard: (boole boole-andc1 word (1- word))
  (logand (lognot word) (1- word)))

(defun word-with-0s-at-trailing-1s-and-0s-elsewhere (word)
  "create a word with 0's at the poision of the trailing 1's in word, and 0's elsewhere, producing all 1's if none"
  (logior (lognot word) (1+ word)))

(defun isolate-the-rightmost-1 (word)
  "isolate the rightmost 1-bit, producing 0 if none"
  (logand word (- word)))

(defun word-with-1s-in-position-of-rightmost-1-and-trailing-0s (word)
  "create a word with 1's at the positions of the rightmost 1-bit and tailing 0's, producing all 0's if no 1-bit, and integer 1 if no trailing 0's"
  (logxor word (1- word)))

(defun word-with-1s-in-positions-of-rightmost-0-and-trailing-1s (word)
  "create a word with 1's at the positions of the rightmost 0-bit and tailing 1's, producing all 1's if no 0-bit, and integer 1 if no trailing 1's"
  (logxor word (1+ word)))

;;; These can be used to determine if a non-negative integer is of the form 2^j - 2^k for some j >= k >= 0
(defun turnoff-rightmost-contiguous-string-of-1s (word)
  "turn off the rightmost contiguous string of 1's"
  ;; (logand (+ (logior word (1- word) 1) word) ; this or next
  (logand word (+ (logand word (- word)) word)))
