(in-package #:cl-dsa)

(defun euclid-gcd (num1 num2)
  (declare (type (integer 0 *) num1 num2))
  (cond
    ((zerop num1) num2)
    ((zerop num2) num1)
    (t (do () ((<= num1 0) num2)
	 (if (> num2 num1)
	     (rotatef num1 num2))
	 (decf num1 num2)))))

(defun euclid-gcd-fast (num1 num2)
  (cond
    ((zerop num1) num2)
    ((zerop num2) num1)
    ((> num2 num1) (euclid-gcd-fast num2 num1))
    (t (let ((remainder (rem num1 num2)))
	 (euclid-gcd-fast num2 remainder)))))
