(in-package #:cl-sbcl-ffi)

(define-alien-routine "print_pun" (* char))

(define-alien-routine "dimensional_weight_of_box" float (length unsigned-int) (width unsigned-int) (height unsigned-int))

(define-alien-routine "fahrenheit_to_celsius" float (fahrenheit float))

(define-alien-routine "sphere_volume" float (radius float))

(define-alien-routine "taxed_dollars" float (dollars float) (tax float))

(define-alien-routine "solve_polynomial_for" long (x int))

(define-alien-routine "opt_solve_polynomial_for" long (x int))

;;; example call:
;;; (with-alien ((bills (* char) (sbcl-ffi:dollar-bills 93)))
;;; 	   (with-alien ((bills-str c-string bills)) 
;;; 	     (format t "~a~%" bills-str))
;;; 	   (free-alien bills))
(define-alien-routine "dollar_bills" (* char) (dollars int)) ; need to check if calls to this function adds to memory leak

;;; example call:
;;; (with-alien ((buffer (* char) (make-alien char 200)))
;;;   (sbcl-ffi:loan-repayment 20000.0 6.0 386.66 buffer)
;;;   (with-alien ((f-buf c-string buffer))
;;;     (format t "~a~%" f-buf)
;;;     (free-alien buffer)))
(define-alien-routine "loan_repayment" (* char) (amount float) (rate float) (payment float))
