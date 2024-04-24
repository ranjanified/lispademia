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

(def-fixture with-list-initialized ()
  (with-alien ((head (* singly-linkedlist-node)
		     (list-initialize))
	       (head-key int
		    (slot head 'key))
	       (tail (* singly-linkedlist-node)
		     (slot head 'next))
	       (tail-next (* singly-linkedlist-node)
			  (slot tail 'next)))
    (&body)
    (free-alien tail)
    (free-alien head)))

(test list-initialize
  (with-fixture with-list-initialized ()
    (is-true (= head-key -10))
    (is-false (null tail))
    (is-false (null tail-next))
    (is-true (sap= (alien-sap tail) (alien-sap tail-next)))))

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
	:until (sap= (alien-sap curr-node) (alien-sap tail))
	:do (free-alien curr-node))
      (free-alien tail)
      (free-alien head))))

(test insert-after
  (with-fixture with-keys (20 30 40 50)
    (is-true (= (node-key (next-node head)) 50))
    (is-true (= (node-key (next-node (next-node head))) 40))
    (is-true (= (node-key (next-node (next-node (next-node head)))) 30))
    (is-true (= (node-key (next-node (next-node (next-node (next-node head))))) 20))
    (is-true (sap= (alien-sap (next-node (next-node (next-node (next-node (next-node head)))))) (alien-sap tail)))))

(test delete-next
  (with-fixture with-keys (10 20 30 40)
    (is-true (= (node-key (delete-next head)) 40))
    (is-true (= (node-key (delete-next head)) 30))
    (is-true (= (node-key (delete-next head)) 20))
    (is-true (= (node-key (delete-next head)) 10))

    (is-true (sap= (alien-sap (delete-next head)) (alien-sap tail)))))
