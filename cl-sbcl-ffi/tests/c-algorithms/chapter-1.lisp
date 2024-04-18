(in-package #:cl-sbcl-ffi/tests)

(in-suite* chapter-1 :in c-algorithms)

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
