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

(test turnoff-trailing-1s 
  (is-true (= #b0000 (turnoff-trailing-1s #b0001)))
  (is-true (= #b0010 (turnoff-trailing-1s #b0010)))
  (is-true (= #b0100 (turnoff-trailing-1s #b0100)))
  (is-true (= #b1000 (turnoff-trailing-1s #b1000)))
  (is-true (= #b1000 (turnoff-trailing-1s #b1001)))
  (is-true (= #b1000 (turnoff-trailing-1s #b1011)))
  (is-true (= #b0000 (turnoff-trailing-1s #b1111)))
  (is-true (= #b1000 (turnoff-trailing-1s #b1011)))
  (is-true (= #b1100 (turnoff-trailing-1s #b1101)))
  (is-true (= #b0000 (turnoff-trailing-1s #b1111))))

(test turnon-trailing-0s
  (is-true (= #b-0001 (turnon-trailing-0s #b0000)))
  (is-true (= #b0001 (turnon-trailing-0s #b0001)))
  (is-true (= #b0011 (turnon-trailing-0s #b0010)))
  (is-true (= #b0111 (turnon-trailing-0s #b0100)))
  (is-true (= #b1111 (turnon-trailing-0s #b1000)))
  (is-true (= #b0011 (turnon-trailing-0s #b0011)))
  (is-true (= #b0101 (turnon-trailing-0s #b0101)))
  (is-true (= #b1001 (turnon-trailing-0s #b1001)))
  (is-true (= #b1011 (turnon-trailing-0s #b1010)))
  (is-true (= #b1111 (turnon-trailing-0s #b1100))))

(test word-with-only-1-bit-in-rightmost-0-bit-position
  (is-true (= #b0001 (word-with-only-1-bit-in-rightmost-0-bit-position #b0000)))
  (is-true (= #b0010 (word-with-only-1-bit-in-rightmost-0-bit-position #b0001)))
  (is-true (= #b0001 (word-with-only-1-bit-in-rightmost-0-bit-position #b0010)))
  (is-true (= #b0001 (word-with-only-1-bit-in-rightmost-0-bit-position #b0100)))
  (is-true (= #b0001 (word-with-only-1-bit-in-rightmost-0-bit-position #b1000)))
  (is-true (= #b0100 (word-with-only-1-bit-in-rightmost-0-bit-position #b0011)))
  (is-true (= #b0010 (word-with-only-1-bit-in-rightmost-0-bit-position #b0101)))
  (is-true (= #b0010 (word-with-only-1-bit-in-rightmost-0-bit-position #b1101)))
  (is-true (= #b0100 (word-with-only-1-bit-in-rightmost-0-bit-position #b1011)))
  (is-true (= #b1000 (word-with-only-1-bit-in-rightmost-0-bit-position #b0111))))

(test word-with-only-0-bit-in-rightmost-1-bit-position
  (is-true (= #-b0001 (word-with-only-0-bit-in-rightmost-1-bit-position #b0000))) ; not 2's complement representation
  (is-true (= #b-0010 (word-with-only-0-bit-in-rightmost-1-bit-position #b0001)))
  (is-true (= #b-0011 (word-with-only-0-bit-in-rightmost-1-bit-position #b0010)))
  (is-true (= #b-0101 (word-with-only-0-bit-in-rightmost-1-bit-position #b0100)))
  (is-true (= #b-1001 (word-with-only-0-bit-in-rightmost-1-bit-position #b1000)))
  (is-true (= #b-0010 (word-with-only-0-bit-in-rightmost-1-bit-position #b0011)))
  (is-true (= #b-0010 (word-with-only-0-bit-in-rightmost-1-bit-position #b0101)))
  (is-true (= #b-0010 (word-with-only-0-bit-in-rightmost-1-bit-position #b1101)))
  (is-true (= #b-0010 (word-with-only-0-bit-in-rightmost-1-bit-position #b1011)))
  (is-true (= #b-0010 (word-with-only-0-bit-in-rightmost-1-bit-position #b0111))))

(test word-with-1s-at-tailing-0s-and-0s-elsewhere
  (is-true (= #-b0001 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b0000))) ; not 2's complement representation
  (is-true (= #b0000 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b0001)))
  (is-true (= #b0001 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b0010)))
  (is-true (= #b0011 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b0100)))
  (is-true (= #b0111 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b1000)))
  (is-true (= #b0000 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b0011)))
  (is-true (= #b0000 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b0101)))
  (is-true (= #b0000 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b1101)))
  (is-true (= #b0000 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b1011)))
  (is-true (= #b0000 (word-with-1s-at-tailing-0s-and-0s-elsewhere #b0111))))

(test word-with-1s-at-tailing-0s-and-0s-elsewhere
  (is-true (= #b-0001 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b0000))) ; not 2's complement representation
  (is-true (= #b-0010 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b0001)))
  (is-true (= #b-0001 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b0010)))
  (is-true (= #b-0001 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b0100)))
  (is-true (= #b-0001 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b1000)))
  (is-true (= #b-0100 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b0011)))
  (is-true (= #b-0010 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b0101)))
  (is-true (= #b-0010 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b1101)))
  (is-true (= #b-0100 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b1011)))
  (is-true (= #b-1000 (word-with-0s-at-trailing-1s-and-0s-elsewhere #b0111))))
