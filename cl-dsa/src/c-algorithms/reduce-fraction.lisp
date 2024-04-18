(in-package #:cl-dsa)

(defstruct fraction
  (numerator   0 :type integer)
  (denominator 0 :type integer))

(defun reduce-fraction (fraction)
  (declare (type fraction fraction))
  (let* ((numerator     (fraction-numerator fraction))
	 (denominator   (fraction-denominator fraction))
	 (num-sign      (if (minusp numerator) -1 1))
	 (denom-sign    (if (minusp denominator) -1 1))
	 (gcd-num-denom (euclid-gcd (abs numerator) (abs denominator))))
    
    (unless (zerop gcd-num-denom)
      (setf (fraction-numerator fraction)   (* num-sign denom-sign (abs (round numerator gcd-num-denom))))
      (setf (fraction-denominator fraction) (abs (round denominator gcd-num-denom))))))
