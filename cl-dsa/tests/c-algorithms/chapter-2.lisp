(in-package #:cl-dsa/tests)

(in-suite* calg-chapter-2 :in c-algorithms)

(test euclid-gcd
  (is-true (zerop (euclid-gcd 0  0)))
  (is-true (=     (euclid-gcd 3  0) 3))
  (is-true (=     (euclid-gcd 0  3) 3))
  (is-true (=     (euclid-gcd 17 5) 1))
  (is-true (=     (euclid-gcd 6 18) 6)))

(test euclid-gcd-fast
  (is-true (zerop (euclid-gcd-fast 0  0)))
  (is-true (=     (euclid-gcd-fast 3  0) 3))
  (is-true (=     (euclid-gcd-fast 0  3) 3))
  (is-true (=     (euclid-gcd-fast 17 5) 1))
  (is-true (=     (euclid-gcd-fast 6 18) 6)))

(test gcd-triplet
  (is-true (zerop (gcd-triplet 0  0 0)))
  (is-true (=     (gcd-triplet 3  0 0) 3))
  (is-true (=     (gcd-triplet 0  3 3) 3))
  (is-true (=     (gcd-triplet 15 5 3) 1))
  (is-true (=     (gcd-triplet 6 18 3) 3)))

(def-fixture with-reduced-fraction (fraction)
  (reduce-fraction fraction)
  (let ((reduced-numerator   (fraction-numerator   fraction))
	(reduced-denominator (fraction-denominator fraction)))
    (&body)))

(test reduce-fraction
  (with-fixture with-reduced-fraction ((make-fraction :numerator 0 :denominator 0))
    (is-true (and (zerop reduced-numerator)
		  (zerop reduced-denominator))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator 0 :denominator 1))
    (is-true (and (zerop reduced-numerator)
		  (= reduced-denominator 1))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator 11 :denominator 11))
    (is-true (and (= reduced-numerator   1)
		  (= reduced-denominator 1))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator -11 :denominator 22))
    (is-true (and (= reduced-numerator  -1)
		  (= reduced-denominator 2))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator 11 :denominator -22))
    (is-true (and (= reduced-numerator  -1)
		  (= reduced-denominator 2))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator -11 :denominator -22))
    (is-true (and (= reduced-numerator   1)
		  (= reduced-denominator 2)))))

(test convert-int
  (is-true (zerop (convert-int   "0")))
  (is-true (=     (convert-int   "1") 1))
  (is-true (=     (convert-int  "10") 10))
  (is-true (=     (convert-int "101") 101)))

(test binary
  (is-true (string= (binary 0) "0"))
  (is-true (string= (binary 1) "1"))
  (is-true (string= (binary 2) "10"))
  (is-true (string= (binary 3) "11"))
  (is-true (string= (binary 4) "100"))
  (is-true (string= (binary 5) "101"))
  (is-true (string= (binary 6) "110"))
  (is-true (string= (binary 7) "111"))
  (is-true (string= (binary 8) "1000"))
  (is-true (string= (binary 9) "1001")))

(test largest-pair-with-gcd-1
  (let ((largest-pair (largest-pair-with-gcd-1)))
    (is-true (= (first largest-pair) most-positive-fixnum)
	     (= (second largest-pair) (1- most-positive-fixnum)))))