(in-package #:cl-sbcl-ffi/tests)

(in-suite* calg-chapter-3 :in c-algorithms)

(def-fixture with-sieve-primes-upto (primes-upto)
  (let ((dummy-primes-count 0)) 
    (multiple-value-bind (c-primes primes-count) (cl-sbcl-ffi:sieve-primes primes-upto dummy-primes-count)
      (let ((primes (loop :with primes-arr := (make-array (list primes-count) :initial-element 0)
			  :for i :from 0 :upto (1- primes-count)
			  :do (setf (aref primes-arr i) (deref c-primes i))
			  :finally (return primes-arr))))
	(&body))
      (free-alien c-primes))))

(test sieve-primes
  (with-fixture with-sieve-primes-upto (0)
    (is-true (equalp primes (vector)))
    (is-true (zerop primes-count)))

  (with-fixture with-sieve-primes-upto (1)
    (is-true (equalp primes (vector)))
    (is-true (zerop primes-count)))

  (with-fixture with-sieve-primes-upto (2)
    (is-true (equalp primes (vector 2)))
    (is-true (= primes-count 1)))

  (with-fixture with-sieve-primes-upto (3)
    (is-true (equalp primes (vector 2 3)))
    (is-true (= primes-count 2)))

  
  (with-fixture with-sieve-primes-upto (5)
    (is-true (equalp primes (vector 2 3 5)))
    (is-true (= primes-count 3)))

  (with-fixture with-sieve-primes-upto (10)
    (is-true (equalp primes (vector 2 3 5 7)))
    (is-true (= primes-count 4)))

  (with-fixture with-sieve-primes-upto (20)
    (is-true (equalp primes (vector 2 3 5 7 11 13 17 19)))
    (is-true (= primes-count 8)))

  (with-fixture with-sieve-primes-upto (30)
    (is-true (equalp primes (vector 2 3 5 7 11 13 17 19 23 29)))
    (is-true (= primes-count 10)))

  (with-fixture with-sieve-primes-upto (40)
    (is-true (equalp primes (vector 2 3 5 7 11 13 17 19 23 29 31 37)))
    (is-true (= primes-count 12)))

  (with-fixture with-sieve-primes-upto (1000)
    (is-true (equalp primes (vector 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103
				   107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199
				   211 223 227 229 233 239 241 251 257 263 269 271 277 281 283 293 307 311 313
				   317 331 337 347 349 353 359 367 373 379 383 389 397 401 409 419 421 431 433
				   439 443 449 457 461 463 467 479 487 491 499 503 509 521 523 541 547 557 563
				   569 571 577 587 593 599 601 607 613 617 619 631 641 643 647 653 659 661 673
				   677 683 691 701 709 719 727 733 739 743 751 757 761 769 773 787 797 809 811
				   821 823 827 829 839 853 857 859 863 877 881 883 887 907 911 919 929 937 941
				   947 953 967 971 977 983 991 997)))
    (is-true (= primes-count 168))))

(def-fixture with-keys (&rest keys)
  (flet ((next-node (node) (slot node 'next))
	 (node-key (node) (slot node 'key)))
    (with-alien ((head (* singly-linkedlist-node)
		       (list-initialize))
		 (tail (* singly-linkedlist-node)
		       (slot head 'next)))
      (loop
	:for key :in keys
	:do (insert-after head key))
      (&body)
      ;; free the nodes - head, tail, and all constituents
      (loop
	:for curr-node := (next-node head) :then (next-node curr-node)
	:until (sap= (alien-sap curr-node)
		     (alien-sap tail))
	:do (free-alien curr-node))
      (free-alien tail)
      (free-alien head))))

(test list-initialize
  (with-fixture with-keys ()
    (is-false (null head))
    (is-false (null tail))
    (is-false (null (next-node tail)))
    (is-false (sap= (alien-sap head)
		    (alien-sap tail)))
    (is-true  (sap= (alien-sap tail)
		    (alien-sap (next-node tail))))))

(test insert-after
  (with-fixture with-keys (20 30 40 50)
    (is-true (= (node-key (next-node head)) 50))
    (is-true (= (node-key (next-node (next-node head))) 40))
    (is-true (= (node-key (next-node (next-node (next-node head)))) 30))
    (is-true (= (node-key (next-node (next-node (next-node (next-node head))))) 20))
    (is-true (sap= (alien-sap (next-node (next-node (next-node (next-node (next-node head))))))
		   (alien-sap tail)))))

(test delete-next
  (with-fixture with-keys (10 20 30 40)
    (is-true (= (node-key (delete-next head)) 40))
    (is-true (= (node-key (delete-next head)) 30))
    (is-true (= (node-key (delete-next head)) 20))
    (is-true (= (node-key (delete-next head)) 10))
    (is-true (sap= (alien-sap (delete-next head))
		   (alien-sap tail)))))

(def-fixture with-singly-ll (&rest keys)
  (flet ((node-key (node) (deref singly-ll-keys node))
	 (next-node (node) (deref singly-ll-nexts node)))
    (loop
      :for index :from 0 :below 102
      :do (setf (deref singly-ll-keys index) 0)
	  (setf (deref singly-ll-nexts index) 0))
    (singly-ll-initialize)
    (loop
      :for key :in keys
      :for current-node := singly-ll-head :then (next-node current-node) 
      :do (singly-ll-insert-after current-node key))
    (let ((head singly-ll-head)
	  (tail singly-ll-tail)
	  (current singly-ll-current))
      (&body))))

(test singly-ll-initialize
  (with-fixture with-singly-ll ()
    (is-true (zerop head))
    (is-true (= tail 1))
    (is-true (= current 2))
    (is-true (= (next-node tail) tail))
    (is-true (= (next-node head) tail))))

(test singly-ll-delete-next
  (with-fixture with-singly-ll (10 20)
    (singly-ll-delete-next head)
    (is-true (= current 4))
    (is-true (= (next-node tail) tail))
    (is-false (= (next-node head) tail))
    (is-true (= (node-key (next-node head)) 20))))

(test singly-ll-insert-after
  (with-fixture with-singly-ll (40 50 60)
    (is-true (= current 5))
    (is-true (= (node-key (next-node head)) 40))
    (is-true (= (node-key (next-node (next-node head))) 50))
    (is-true (= (node-key (next-node (next-node (next-node head)))) 60))
    (is-true (= (next-node (next-node (next-node (next-node head)))) tail))))
