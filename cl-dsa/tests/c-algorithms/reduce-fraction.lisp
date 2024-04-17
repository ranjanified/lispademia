(in-package #:cl-dsa/tests)

(in-suite* c-algorithms :in cl-dsa-tests)

(def-fixture with-reduced-fraction (fraction)
  (let* ((reduced-fraction         (reduce-fraction      fraction))
	 (reduced-numerator        (fraction-numerator   reduced-fraction))
	 (reduced-denominator      (fraction-denominator reduced-fraction)))
    (&body)))

(test reduce-fraction
  (with-fixture with-reduced-fraction ((make-fraction :numerator 0 :denominator 0))
    (is-true (and (zerop reduced-numerator)
		  (zerop reduced-denominator))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator 0 :denominator 1))
    (is-true (and (zerop reduced-numerator)
		  (= reduced-denominator 1))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator 11 :denominator 11))
    (is-true (and (= reduced-numerator 1)
		  (= reduced-denominator 1))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator -11 :denominator 22))
    (is-true (and (= reduced-numerator -1)
		  (= reduced-denominator 2))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator 11 :denominator -22))
    (is-true (and (= reduced-numerator -1)
		  (= reduced-denominator 2))))

  (with-fixture with-reduced-fraction ((make-fraction :numerator -11 :denominator -22))
    (is-true (and (= reduced-numerator   1)
		  (= reduced-denominator 2)))))
