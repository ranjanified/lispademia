(in-package #:cl-sbcl-ffi)

(define-alien-routine "euclid_gcd" unsigned-int (num1 unsigned-long) (num2 unsigned-long))

;;; example call:
;;; the binding fraction is a local alien. Lisp should be doing GC for it
;;; (with-alien ((fraction cl-sbcl-ffi:fraction))
;;;   (setf (slot fraction 'numerator) 7)
;;;   (setf (slot fraction 'denominator) 5)
;;;   (cl-sbcl-ffi:reduce-fraction (addr fraction))
;;;   (format t "Numerator: ~a~%Denominator: ~a~%" 
;;; 	  (slot fraction 'numerator) 
;;; 	  (slot fraction 'denominator)))
(define-alien-type fraction (struct fraction (numerator int) (denominator int)))
(define-alien-routine "reduce_fraction" void (curr-fraction (* fraction)))

(define-alien-routine "convert_int" int (number-str c-string))

(define-alien-routine "binary" (* char) (number int))
