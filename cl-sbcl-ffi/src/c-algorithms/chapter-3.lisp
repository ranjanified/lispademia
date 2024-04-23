(in-package #:cl-sbcl-ffi)

;;; Example Call:
;;; (let ((dummy-primes-count 0)
;;;       (primes-upto 100)) 
;;;   (multiple-value-bind (primes primes-count) (sieve-primes primes-upto dummy-primes-count)
;;;     (prog1
;;;         ;; copy contents of c-array into Lisp array
;;; 	    (loop :with primes-arr := (make-array (list primes-count) :initial-element 0)
;;; 	          :for i :from 0 :upto (1- primes-count)
;;; 	          :do (setf (aref primes-arr i) (deref primes i))
;;; 	          :finally (return primes-arr))
;;;       (free-alien primes))))
(define-alien-routine "sieve_primes" (* unsigned-int) (primes-upto unsigned-int) (primes-count unsigned-int :in-out))


(define-alien-type nil
    (struct node
	    (key int)
	    (next (* (struct node)))))

;;; Example Call:
;;; (with-alien ((head (* (struct cl-sbcl-ffi::node)) 
;;; 		       (cl-sbcl-ffi:list-initialize)))
;;;   (format t "~a~%" (slot head 'cl-sbcl-ffi::key))
;;;   (free-alien (slot head 'cl-sbcl-ffi::next))
;;;   (free-alien head))
(define-alien-routine "list_initialize" (* (struct node)))
(define-alien-routine "delete_next"     (* (struct node)) (node (* (struct node))))
(define-alien-routine "insert_after"    (* (struct node)) (node (* (struct node))) (key int))
