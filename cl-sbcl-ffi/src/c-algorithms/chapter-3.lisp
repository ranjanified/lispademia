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


(define-alien-type singly-linkedlist-node
    (struct node
	    (key int)
	    (next (* (struct node)))))

;;; Example Call:
;;; (with-alien ((head (* singly-linkedlist-node)) 
;;; 		       (cl-sbcl-ffi:list-initialize)))
;;;   (format t "~a~%" (slot head 'cl-sbcl-ffi:key))
;;;   (free-alien (slot head 'cl-sbcl-ffi:next))
;;;   (free-alien head))
(define-alien-routine "list_initialize" (* singly-linkedlist-node))
(define-alien-routine "delete_next"     (* singly-linkedlist-node) (node (* singly-linkedlist-node)))
(define-alien-routine "insert_after"    (* singly-linkedlist-node) (node (* singly-linkedlist-node)) (key int))

(define-alien-variable "singly_ll_keys" (array int 102))
(define-alien-variable "singly_ll_nexts" (array int 102))
(define-alien-variable "singly_ll_head" unsigned-int)
(define-alien-variable "singly_ll_tail" unsigned-int)
(define-alien-variable "singly_ll_current" unsigned-int)

(define-alien-routine "singly_ll_initialize" void)
(define-alien-routine "singly_ll_delete_next" void (node unsigned-int))
(define-alien-routine "singly_ll_insert_after" unsigned-int (node unsigned-int) (key int))

(define-alien-type stack-struct
    (struct stack
	    (head (* singly-linkedlist-node))
	    (tail (* singly-linkedlist-node))))

(define-alien-routine "stack_initialize" (* stack-struct))
(define-alien-routine "stack_push" (* singly-linkedlist-node) (stack (* stack-struct)) (key int))
(define-alien-routine "stack_pop" int (stack (* stack-struct)))
(define-alien-routine "stack_empty" int (stack (* stack-struct)))
(define-alien-routine "stack_contents" (* char) (stack (* stack-struct)))
(define-alien-routine "stack_uninitialize" void (stack (* stack-struct))) 

(define-alien-routine "infix_postfix" (* char) (infix c-string))

(define-alien-type queue-struct
    (struct queue
	    (head (* singly-linkedlist-node))
	    (tail (* singly-linkedlist-node))))
(define-alien-routine "queue_initialize" (* queue-struct))
(define-alien-routine "queue_insert" (* singly-linkedlist-node) (queue (* queue-struct)) (key int))
(define-alien-routine "queue_remove" int (queue (* queue-struct)))
(define-alien-routine "queue_empty" unsigned-short (queue (* queue-struct)))

(define-alien-routine "fill_having_gcd_1" (* (* unsigned-short)) (rows unsigned-short) (columns unsigned-short))
(define-alien-routine "free_fill_array_having_gcd_1" void (fill-array (* (* unsigned-short))) (rows unsigned-short))
