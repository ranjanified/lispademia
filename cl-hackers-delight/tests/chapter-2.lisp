(in-package #:cl-hackers-delight/tests)

(in-suite* cl-hackers-delight)

(test turnoff-rightmost-1
  (let ((x #b0001)) (is-true (= #b0000 (turnoff-rightmost-1 x))))
  (is-true (= #b0000 (turnoff-rightmost-1 #b0010)))
  (is-true (= #b0010 (turnoff-rightmost-1 #b0011)))
  (is-true (= #b0000 (turnoff-rightmost-1 #b0100)))
  (is-true (= #b0100 (turnoff-rightmost-1 #b0101)))
  (is-true (= #b0100 (turnoff-rightmost-1 #b0110)))
  (is-true (= #b0110 (turnoff-rightmost-1 #b0111)))
  (is-true (= #b0000 (turnoff-rightmost-1 #b1000)))
  (is-true (= #b1000 (turnoff-rightmost-1 #b1100)))
  (is-true (= #b1000 (turnoff-rightmost-1 #b1010))))

(test turnon-rightmost-0
  (is-true (= #b0011 (turnon-rightmost-0 #b0001)))
  (is-true (= #b0011 (turnon-rightmost-0 #b0010)))
  (is-true (= #b0111 (turnon-rightmost-0 #b0011)))
  (is-true (= #b0101 (turnon-rightmost-0 #b0100)))
  (is-true (= #b0111 (turnon-rightmost-0 #b0101)))
  (is-true (= #b0111 (turnon-rightmost-0 #b0110)))
  (is-true (= #b1111 (turnon-rightmost-0 #b0111)))
  (is-true (= #b1001 (turnon-rightmost-0 #b1000)))
  (is-true (= #b1101 (turnon-rightmost-0 #b1100)))
  (is-true (= #b1011 (turnon-rightmost-0 #b1010))))
