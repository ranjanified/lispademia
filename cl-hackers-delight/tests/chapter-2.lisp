(in-package #:cl-hackers-delight/tests)

(in-suite* cl-hackers-delight)

(test turnoff-rightmost-1
  "turns off the rightmost 1"
  (let ((x #b0001)) (is-true (= #b0000 (logand x (1- x)))))
  (is-true (= #b0000 (logand #b0010 #b0001)))
  (is-true (= #b0010 (logand #b0011 #b0010)))
  (is-true (= #b0000 (logand #b0100 #b0011)))
  (is-true (= #b0100 (logand #b0101 #b0100)))
  (is-true (= #b0100 (logand #b0110 #b0101)))
  (is-true (= #b0110 (logand #b0111 #b0110)))
  (is-true (= #b0000 (logand #b1000 #b0111)))
  (is-true (= #b1000 (logand #b1100 #b1001)))
  (is-true (= #b1000 (logand #b1010 #b1001))))

(test turnoff-rightmost-0
  "turns off the rightmost 0"
  (let ((x #b0001)) (is-true (= #b0011 (logior x (1+ x)))))
  (is-true (= #b0011 (logior #b0010 #b0011)))
  (is-true (= #b0111 (logior #b0011 #b0100)))
  (is-true (= #b0101 (logior #b0100 #b0101)))
  (is-true (= #b0111 (logior #b0101 #b0110)))
  (is-true (= #b0111 (logior #b0110 #b0111)))
  (is-true (= #b1111 (logior #b0111 #b1000)))
  (is-true (= #b1001 (logior #b1000 #b1001)))
  (is-true (= #b1101 (logior #b1100 #b1101)))
  (is-true (= #b1011 (logior #b1010 #b1011))))
