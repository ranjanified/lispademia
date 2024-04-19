(in-package #:cl-sbcl-ffi/tests)

(in-suite* chapter-1 :in c-algorithms)

(test euclid-gcd
  (is-true (zerop (euclid-gcd 0  0)))
  (is-true (=     (euclid-gcd 3  0) 3))
  (is-true (=     (euclid-gcd 0  3) 3))
  (is-true (=     (euclid-gcd 17 5) 1))
  (is-true (=     (euclid-gcd 6 18) 6)))

(def-fixture with-reduced-fraction (numerator denominator)
  ;; a local alien which should be garbage collected by Lisp,
  ;; no need to (free-alien ...) this one
  (with-alien ((curr-fraction fraction))
    (setf (slot curr-fraction 'numerator)     numerator)
    (setf (slot curr-fraction 'denominator) denominator)
    (reduce-fraction (addr curr-fraction)) 
    (let ((reduced-numerator   (slot curr-fraction   'numerator))
	  (reduced-denominator (slot curr-fraction 'denominator)))
      (&body))))

(test reduce-fraction
  (with-fixture with-reduced-fraction (0 0)
    (is-true (and (zerop reduced-numerator)
		  (zerop reduced-denominator))))
  
  (with-fixture with-reduced-fraction (0 1)
    (is-true (and (zerop reduced-numerator)
		  (= reduced-denominator 1))))
  
  (with-fixture with-reduced-fraction (11 11)
    (is-true (and (= reduced-numerator   1)
		  (= reduced-denominator 1))))
  
  (with-fixture with-reduced-fraction (11 22)
    (is-true (and (= reduced-numerator   1)
		  (= reduced-denominator 2))))
  
  (with-fixture with-reduced-fraction (-11 22)
    (is-true (and (= reduced-numerator  -1)
		  (= reduced-denominator 2))))
  
  (with-fixture with-reduced-fraction (11 -22)
    (is-true (and (= reduced-numerator  -1)
		  (= reduced-denominator 2))))
  
  (with-fixture with-reduced-fraction (-11 -22)
    (is-true (and (= reduced-numerator   1)
		  (= reduced-denominator 2))))
  
  (with-fixture with-reduced-fraction (-22 -11)
    (is-true (and (= reduced-numerator   2)
		  (= reduced-denominator 1))))

  (with-fixture with-reduced-fraction (7 5)
    (is-true (and (= reduced-numerator   7)
		  (= reduced-denominator 5))))

  (with-fixture with-reduced-fraction (-5 -7)
    (is-true (and (= reduced-numerator   5)
		  (= reduced-denominator 7)))))

(def-fixture with-number-string (num-str)
  (with-alien ((number-str c-string num-str))
    (let ((converted-int (convert-int number-str)))
      (&body))))

(test convert-int
  (with-fixture with-number-string ("0")
    (is-true (zerop converted-int)))

  (with-fixture with-number-string ("1")
    (is-true (= converted-int 1)))

  (with-fixture with-number-string ("10")
    (is-true (= converted-int 10)))

  (with-fixture with-number-string ("103")
    (is-true (= converted-int 103)))

  (with-fixture with-number-string ("17486")
    (is-true (= converted-int 17486))))

(def-fixture with-int-binary (num)
  (with-alien ((binary-string (* char) (binary num)))
    (with-alien ((converted-binary c-string binary-string))
      (&body))
    (free-alien binary-string)))

(test binary
  (with-fixture with-int-binary (0)
    (is-true (string= converted-binary "0")))

  (with-fixture with-int-binary (1)
    (is-true (string= converted-binary "1")))

  (with-fixture with-int-binary (2)
    (is-true (string= converted-binary "10")))

  (with-fixture with-int-binary (3)
    (is-true (string= converted-binary "11")))

  (with-fixture with-int-binary (4)
    (is-true (string= converted-binary "100")))

  (with-fixture with-int-binary (5)
    (is-true (string= converted-binary "101")))

  (with-fixture with-int-binary (6)
    (is-true (string= converted-binary "110")))

  (with-fixture with-int-binary (7)
    (is-true (string= converted-binary "111")))

  (with-fixture with-int-binary (8)
    (is-true (string= converted-binary "1000")))

  (with-fixture with-int-binary (9)
    (is-true (string= converted-binary "1001"))))
