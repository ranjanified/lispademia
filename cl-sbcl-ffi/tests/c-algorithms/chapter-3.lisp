(in-package #:cl-sbcl-ffi/tests)

;; (declaim (optimize (debug 3)))

(in-suite* calg-chapter-3 :in c-algorithms)

;; (def-fixture with-sieve-primes-upto (primes-upto)
;;   (let ((dummy-primes-count 0)) 
;;     (multiple-value-bind (c-primes primes-count) (cl-sbcl-ffi:sieve-primes primes-upto dummy-primes-count)
;;       (let ((primes (loop :with primes-arr := (make-array (list primes-count) :initial-element 0)
;; 			  :for i :from 0 :upto (1- primes-count)
;; 			  :do (setf (aref primes-arr i) (deref c-primes i))
;; 			  :finally (return primes-arr))))
;; 	(&body))
;;       (free-alien c-primes))))

;; (test sieve-primes
;;   (with-fixture with-sieve-primes-upto (0)
;;     (is-true (equalp primes (vector)))
;;     (is-true (zerop primes-count)))

;;   (with-fixture with-sieve-primes-upto (1)
;;     (is-true (equalp primes (vector)))
;;     (is-true (zerop primes-count)))

;;   (with-fixture with-sieve-primes-upto (2)
;;     (is-true (equalp primes (vector 2)))
;;     (is-true (= primes-count 1)))

;;   (with-fixture with-sieve-primes-upto (3)
;;     (is-true (equalp primes (vector 2 3)))
;;     (is-true (= primes-count 2)))

  
;;   (with-fixture with-sieve-primes-upto (5)
;;     (is-true (equalp primes (vector 2 3 5)))
;;     (is-true (= primes-count 3)))

;;   (with-fixture with-sieve-primes-upto (10)
;;     (is-true (equalp primes (vector 2 3 5 7)))
;;     (is-true (= primes-count 4)))

;;   (with-fixture with-sieve-primes-upto (20)
;;     (is-true (equalp primes (vector 2 3 5 7 11 13 17 19)))
;;     (is-true (= primes-count 8)))

;;   (with-fixture with-sieve-primes-upto (30)
;;     (is-true (equalp primes (vector 2 3 5 7 11 13 17 19 23 29)))
;;     (is-true (= primes-count 10)))

;;   (with-fixture with-sieve-primes-upto (40)
;;     (is-true (equalp primes (vector 2 3 5 7 11 13 17 19 23 29 31 37)))
;;     (is-true (= primes-count 12)))

;;   (with-fixture with-sieve-primes-upto (1000)
;;     (is-true (equalp primes (vector 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103
;; 				   107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199
;; 				   211 223 227 229 233 239 241 251 257 263 269 271 277 281 283 293 307 311 313
;; 				   317 331 337 347 349 353 359 367 373 379 383 389 397 401 409 419 421 431 433
;; 				   439 443 449 457 461 463 467 479 487 491 499 503 509 521 523 541 547 557 563
;; 				   569 571 577 587 593 599 601 607 613 617 619 631 641 643 647 653 659 661 673
;; 				   677 683 691 701 709 719 727 733 739 743 751 757 761 769 773 787 797 809 811
;; 				   821 823 827 829 839 853 857 859 863 877 881 883 887 907 911 919 929 937 941
;; 				   947 953 967 971 977 983 991 997)))
;;     (is-true (= primes-count 168))))

;; (def-fixture with-keys (&rest keys)
;;   (flet ((next-node (node) (slot node 'next))
;; 	 (node-key (node) (slot node 'key)))
;;     (with-alien ((head (* singly-linkedlist-node)
;; 		       (list-initialize))
;; 		 (tail (* singly-linkedlist-node)
;; 		       (slot head 'next)))
;;       (loop
;; 	:for key :in keys
;; 	:for current-node := head :then (next-node current-node)
;; 	:do (insert-after current-node key))
;;       (&body)
;;       ;; free the nodes - head, tail, and all constituents
;;       (loop
;; 	:for curr-node := (next-node head) :then (next-node curr-node)
;; 	:until (sap= (alien-sap curr-node)
;; 		     (alien-sap tail))
;; 	:do ;; (format t "~&freeing key-node~%")
;; 	    (free-alien curr-node)
;; 	    ;; (format t "~&freed key-node~%")
;; 	)
;;       ;; (format t "~&freeing tail-node~%")
;;       (free-alien tail)
;;       ;; (format t "~&freed tail-node~%")
;;       ;; (format t "freeing head-node~%")
;;       (free-alien head)
;;       ;; (format t "~&freed head-node~%")
;;       )))

;; (test list-initialize
;;   (with-fixture with-keys ()
;;     (is-false (null head))
;;     (is-false (null tail))
;;     (is-false (null (next-node tail)))
;;     (is-false (sap= (alien-sap head)
;; 		    (alien-sap tail)))
;;     (is-true  (sap= (alien-sap tail)
;; 		    (alien-sap (next-node tail))))))

;; (test insert-after
;;   (with-fixture with-keys (20 30 40 50)
;;     (is-true (= (node-key (next-node head)) 20))
;;     (is-true (= (node-key (next-node (next-node head))) 30))
;;     (is-true (= (node-key (next-node (next-node (next-node head)))) 40))
;;     (is-true (= (node-key (next-node (next-node (next-node (next-node head))))) 50))
;;     (is-true (sap= (alien-sap (next-node (next-node (next-node (next-node (next-node head))))))
;; 		   (alien-sap tail)))))

;; (test delete-next
;;   (with-fixture with-keys (10 20 30 40)
;;     (is-true (= (node-key (delete-next head)) 10))
;;     (is-true (= (node-key (delete-next head)) 20))
;;     (is-true (= (node-key (delete-next head)) 30))
;;     (is-true (= (node-key (delete-next head)) 40))
;;     (is-true (sap= (alien-sap (delete-next head))
;; 		   (alien-sap tail)))))

;; (def-fixture with-singly-ll (&rest keys)
;;   (flet ((node-key (node) (deref singly-ll-keys node))
;; 	 (next-node (node) (deref singly-ll-nexts node)))
;;     (loop
;;       :for index :from 0 :below 102
;;       :do (setf (deref singly-ll-keys index) 0)
;; 	  (setf (deref singly-ll-nexts index) 0))
;;     (singly-ll-initialize)
;;     (loop
;;       :for key :in keys
;;       :for current-node := singly-ll-head :then (next-node current-node) 
;;       :do (singly-ll-insert-after current-node key))
;;     (let ((head singly-ll-head)
;; 	  (tail singly-ll-tail)
;; 	  (current singly-ll-current))
;;       (&body))))

;; (test singly-ll-initialize
;;   (with-fixture with-singly-ll ()
;;     (is-true (zerop head))
;;     (is-true (= tail 1))
;;     (is-true (= current 2))
;;     (is-true (= (next-node tail) tail))
;;     (is-true (= (next-node head) tail))))

;; (test singly-ll-delete-next
;;   (with-fixture with-singly-ll (10 20)
;;     (singly-ll-delete-next head)
;;     (is-true (= current 4))
;;     (is-true (= (next-node tail) tail))
;;     (is-false (= (next-node head) tail))
;;     (is-true (= (node-key (next-node head)) 20))))

;; (test singly-ll-insert-after
;;   (with-fixture with-singly-ll (40 50 60)
;;     (is-true (= current 5))
;;     (is-true (= (node-key (next-node head)) 40))
;;     (is-true (= (node-key (next-node (next-node head))) 50))
;;     (is-true (= (node-key (next-node (next-node (next-node head)))) 60))
;;     (is-true (= (next-node (next-node (next-node (next-node head)))) tail))))

;; (def-fixture with-stack (&rest keys)
;;   (flet ((next-node (node) (slot node 'next)))
;;     (with-alien ((stack (* stack-struct)
;; 			(stack-initialize))
;; 		 (head (* singly-linkedlist-node)
;; 		       (slot stack 'head))
;; 		 (tail (* singly-linkedlist-node)
;; 		       (slot stack 'tail)))
;;       (loop
;; 	:for key :in keys
;; 	:do (stack-push stack key))
;;       (&body)
;;       (stack-uninitialize stack))))

;; (test stack-initialize
;;   (with-fixture with-stack ()
;;     (is-false (null stack))
;;     (is-false (null head))
;;     (is-false (null tail))))

;; (test stack-push
;;   (with-fixture with-stack ()
;;     (stack-push stack 10)
;;     (stack-push stack -20)
;;     (stack-push stack 30)
;;     (is-true (= (stack-pop stack) 30))
;;     (is-true (= (stack-pop stack) -20))
;;     (is-true (= (stack-pop stack) 10))))

;; (test stack-pop
;;   (with-fixture with-stack (10 20 30 40)
;;     (is-true (= (stack-pop stack) 40))
;;     (is-true (= (stack-pop stack) 30))
;;     (is-true (= (stack-pop stack) 20))
;;     (is-true (= (stack-pop stack) 10))))

;; (test stack-empty
;;   ;; from c return values: 1 designates true, 0 designates false
;;   (with-fixture with-stack ()
;;     (is-true (= 1 (stack-empty stack))))

;;   (with-fixture with-stack (1 2 3)
;;     (is (= (stack-empty stack) 0)))

;;   (with-fixture with-stack (1 2 3)
;;     (is-true (= (stack-pop stack) 3))
;;     (is-true (= (stack-pop stack) 2))
;;     (is-true (= (stack-empty stack) 0)))

;;   (with-fixture with-stack ()
;;     (stack-push stack 20)
;;     (is-true (= (stack-empty stack) 0)))

;;   (with-fixture with-stack (10 20)
;;     (is-true (= (stack-pop stack) 20))
;;     (is-true (= (stack-pop stack) 10))
;;     (is-true (= (stack-empty stack) 1))))


;; (test sample-stack
;;   (with-fixture with-stack ()
;;     (loop
;;       :for code :in (mapcar #'char-code (coerce "A*SA*M*P*L*ES*T***A*CK**" 'list))
;;       :if (= code (char-code #\*))
;; 	:do (stack-pop stack)
;;       :else
;; 	:do (stack-push stack code)
;;       :finally
;; 	 (is-true (stack-empty stack)))))

(def-fixture with-stack-contents (content-str)
  (flet ((content-string (stack)
	   (with-alien ((len unsigned-int 0)
			(contents (* int)
				  (stack-contents stack (addr len))))
	     ;; (format t "~&stack-contents length: ~a~%" len)
	     (loop :for i :from 0 :below len
		   :collect (code-char (deref contents i)) :into s-contents
		   :finally (format t "~&freeing alien: ~a~%" (alien-sap contents))
			    (free-alien contents)
			    (setf contents nil)
			    (return (coerce s-contents 'string))))))
    (let* ((stack (stack-initialize))
	   (contents (loop
		       :for code :in (mapcar #'char-code (coerce content-str 'list))
		       :if (= code (char-code #\*))
			 :do (stack-pop stack)
			 :and :collect (content-string stack) :into contents
		       :else
			 :do (stack-push stack code)
			 :and :collect (content-string stack) :into contents
		       :finally (return contents))))
      (&body)
      (format t "~&are we doing this?~%")
      (stack-uninitialize stack))))

(test stack-contents
  (with-fixture with-stack-contents ("EAS*Y**QUE***ST***I*ON**")
    (is-false (null stack))
    (is-true (stack-empty stack))
    (is-true (= (length contents) 24))
    (is-true (equal contents
		    (list "E" "AE" "SAE" "AE" "YAE" 
			  "AE" "E" "QE" "UQE" "EUQE" 
			  "UQE" "QE" "E" "SE" "TSE" 
			  "SE" "E" "" "I" "" "O" "NO" 
			  "O" "")))))

;; (def-fixture with-infix (infix)
;;   (with-alien ((postfix-str (* char) (cl-sbcl-ffi:infix-postfix infix))
;; 	       (postfix c-string postfix-str))
;;     (&body)
;;     (free-alien postfix-str)))

;; (test infix-postfix
;;   (with-fixture with-infix ("")
;;     (is-true (string-equal postfix "")))

;;  (with-fixture with-infix ("A+B")
;;    (is-true (string-equal postfix "AB+")))

;;   (with-fixture with-infix ("(A+B)")
;;     (is-true (string-equal postfix "AB+")))

;;   (with-fixture with-infix ("A+B-C")
;;     (is-true (string-equal postfix "ABC-+")))

;;   (with-fixture with-infix ("(A+B-C)")
;;     (is-true (string-equal postfix "ABC-+")))

;;   (with-fixture with-infix ("A+(B-C)")
;;     (is-true (string-equal postfix "ABC-+")))

;;   (with-fixture with-infix ("(A+B)-C")
;;     (is-true (string-equal postfix "AB+C-")))

;;   (with-fixture with-infix ("(A+B)*(C-D)")
;;     (is-true (string-equal postfix "AB+CD-*")))

;;   (with-fixture with-infix ("A$B*C-D+E/F/(G-H)")
;;     (is-true (string-equal postfix "ABCDEFGH-//+-*$")))

;;   (with-fixture with-infix ("A-B/((C*D)$E)")
;;     (is-true (string-equal postfix "ABCD*E$/-"))))

;; (def-fixture with-queue (&rest keys)
;;   (flet ((next-node (node) (slot node 'next)))
;;     (with-alien ((queue (* queue-struct)
;; 			(queue-initialize))
;; 		 (head (* singly-linkedlist-node)
;; 		       (slot queue 'head))
;; 		 (tail (* singly-linkedlist-node)
;; 		       (slot queue 'tail)))
;;       (loop
;; 	:for key :in keys
;; 	:do (queue-insert queue key))
;;       (&body)
;;       ;; this is possible only in Lisp side, that we are able to call a next-node on key-node
;;       ;; even though we had called a free-alien on key-node prior to it.
;;       ;; And there is a good reason for this to be able to happen ... keep guessing.
;;       (loop
;; 	:for key-node := (next-node head) :then (next-node key-node)
;; 	:until (sap= (alien-sap key-node) (alien-sap tail))
;; 	:do (free-alien key-node))
;;       (free-alien tail)
;;       (free-alien head)
;;       (free-alien queue))))

;; (test queue-initialize
;;   (with-fixture with-queue ()
;;     (is-true queue)
;;     (is-true head)
;;     (is-true tail)
;;     (is-true (= (queue-empty queue) 1))))

;; (test queue-insert
;;   (with-fixture with-queue (1 2 3 4)
;;     (is-true (= 1 (queue-remove queue)))
;;     (is-true (= 2 (queue-remove queue)))
;;     (is-true (= 3 (queue-remove queue)))
;;     (is-true (= 4 (queue-remove queue)))
;;     (is-true (=   (queue-empty queue) 1))))

;; (test queue-remove
;;   (with-fixture with-queue ()
;;     (is-true (= (queue-remove queue) -1))
;;     (is-true (= (queue-empty  queue) 1)))

;;   (with-fixture with-queue (1 2 5)
;;     (is-true (= (queue-remove queue) 1))
;;     (is-true (= (queue-empty  queue) 0)))
  
;;   (with-fixture with-queue (1 2 3)
;;     (is-true (= 1 (queue-remove queue)))
;;     (is-true (= 2 (queue-remove queue)))
;;     (is-true (= 3 (queue-remove queue)))
;;     (is-true (=   (queue-empty queue) 1))))

;; (def-fixture with-fill-array (rows columns)
;;   ;; (sb-sys:without-gcing)
;;   (with-alien ((fill-array (* (* unsigned-short))
;; 			   (fill-having-gcd-1 rows columns)))
;;     (flet ((item-at (row col) (deref (deref fill-array row) col)))
;;       ;; (sb-ext:finalize (item-at 0 0) (lambda () (format t "~&gc 0 0~%")))
;;       (format t "~&lisp: allocated fill-array at: ~a~%" (alien-sap fill-array))
;;       (&body)
;;       ;; (loop :for r :from 0 :below rows
;;       ;; 	    :do (loop :for c :from 0 :below columns
;;       ;; 		      :do (format t "~&Row: ~a, Column: ~a, Value: ~a~%" r c (item-at r c))))

;;       ;; we still have to understand why free-alien of rows was unreliable and flaky
;;       ;; with dynamically allocated 2d arrays on c side.
;;       ;; Even with free on c side, it is non-deterministically erroring FOREIGN-HEAP-CORRUPTION
;;       (format t "~&lisp: freeing array at: ~a~%" (alien-sap fill-array) ;; (sb-sys:sap-ref-word (alien-sap fill-array) 0)
;;       )
;;       (free-fill-array-having-gcd-1 fill-array rows)
;;       (format t "~&lisp: freed array~%"))))

;; (test fill-having-gcd-1
;;   (with-fixture with-fill-array (1 1)
;;     (is-true (zerop (item-at 0 0))))

;;   (with-fixture with-fill-array (2 2)
;;     (is-true (zerop (item-at 0 0)))
;;     (is-true (= (item-at 0 1) 1))
;;     (is-true (= (item-at 1 0) 1))
;;     (is-true (= (item-at 1 1) 1))))

;; (test move-next-to-front
;;   (with-fixture with-keys ()
;;     (move-next-to-front head 10)
;;     (is-true (sap= (alien-sap tail) (alien-sap (next-node head))))))
