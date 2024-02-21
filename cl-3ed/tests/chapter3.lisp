(in-package #:cl-3ed/tests)

(in-suite* chapter3 :in cl-3ed-suite)

(test 3.1-first
  (is-true (null (first (list))))
  (is-true (eql 1 (first (list 1))))
  (is-true (equal (list 1) (first (list (list 1))))))

(test 3.1-rest
  (is-true (null (rest (list))))
  (is-true (null (rest (list 1))))
  (is-true (null (rest (list (list 1)))))
  (is-true (equal (list 2 3) (rest (list 1 2 3))))
  (is-true (equal (list (list 2 3)) (rest (list 1 (list 2 3))))))

(test 3.1-insert
  (is-true (equal (list nil) (insert nil nil)))
  (is-true (equal (list 1) (insert 1 nil)))
  (is-true (equal (list 1 2 3) (insert 1 (list 2 3))))
  (is-true (equal (list (list nil) nil) (insert (list nil) (list nil))))
  (is-true (equal (list (list 1 2 3) (list 4 5 6)) (insert (list 1 2 3) (list (list 4 5 6))))))

(test 3.2-rotate-l
  (is-true (null (rotate-l (list))))
  (is-true (equal (list 1) (rotate-l (list 1))))
  (is-true (equal (list 'b 'c 'a) (rotate-l (list 'a 'b 'c))))
  (is-true (equal (list (list 'a 'b 'c)) (rotate-l (list (list 'a 'b 'c)))))
  (is-true (equal (list 'c 'a 'b) (rotate-l (rotate-l (list 'a 'b 'c)))))
  (is-true (equal (list 'c 'd 'a 'b) (rotate-l (rotate-l (list 'a 'b 'c 'd)))))
  (is-true (equal (list 'a 'b 'c) (rotate-l (rotate-l (rotate-l (list 'a 'b 'c))))))
  (is-true (equal (list 'd 'a 'b 'c) (rotate-l (rotate-l (rotate-l (list 'a 'b 'c 'd)))))))

(test 3.3-rotate-r
  (is-true (null (rotate-r (list))))
  (is-true (equal (list 1) (rotate-r (list 1))))
  (is-true (equal (list 'c 'a 'b) (rotate-r (list 'a 'b 'c))))
  (is-true (equal (list (list 'a 'b 'c)) (rotate-r (list (list 'a 'b 'c)))))
  (is-true (equal (list 'b 'c 'a) (rotate-r (rotate-r (list 'a 'b 'c)))))
  (is-true (equal (list 'c 'd 'a 'b) (rotate-r (rotate-r (list 'a 'b 'c 'd)))))
  (is-true (equal (list 'a 'b 'c) (rotate-r (rotate-r (rotate-r (list 'a 'b 'c)))))))

(test 3.4-palindromize
  (is-true (null (palindromize (list))))
  (is-true (equal (list nil nil) (palindromize (list (list)))))
  (is-true (equal (list t nil nil t) (palindromize (list t nil))))
  (is-true (equal (list t t t t) (palindromize (list t t))))
  (is-true (equal (list t t t t t t) (palindromize (list t t t)))))

(test 3.5-f-to-c
  (is-true (= (f-to-c -40) -40))
  (is-true (eql 37.0 (ffloor (f-to-c 98.6)))))

(test 3.5-c-to-f
  (is-true (= (c-to-f -40) -40))
  (is-true (= 98.6 (* (fround (c-to-f 37.00) 0.1) 0.1))))

(test 3.6-roots
  (is-true (multiple-value-bind (root1 root2) (roots 0.0 0.0 0.0)
	     (and (zerop root1) (zerop root2))))
  (is-true (multiple-value-bind (root1 root2) (roots 1.0 0.0 0.0)
	     (and (zerop root1) (zerop root2))))
  (is-true (multiple-value-bind (root1 root2) (roots 1.0 1.0 0.0)
	     (and (zerop root1) (minusp root2) (= 1.0 (abs root2)))))
  (is-true (multiple-value-bind (root1 root2) (roots 1.0 1.0 1.0)
	     (and (= #C(-0.5 0.8660254) root1)
		  (= #C(-0.5 -0.8660254) root2))))
  (is-true (multiple-value-bind (root1 root2) (roots 1 -3 2)
	     (and (= 2.0 root1) (= 1.0 root2))))
  (is-true (multiple-value-bind (root1 root2) (roots 1 -9 20)
	     (and (= 5.0 root1) (= 4.0 root2)))))

(test 3.7-evenp
  (is-true (evenp 0))
  (is-false (evenp 1))
  (is-true (evenp 2))
  (is-false (evenp 23))
  (is-true (evenp 1024)))

(test 3.8-palindromep
  (is-true (palindrome-p (list)))
  (is-true (palindrome-p (list 1 1)))
  (is-false (palindrome-p (list 1 2)))
  (is-false (palindrome-p (list 1 2 3)))
  (is-true (palindrome-p (list 1 2 2 1))))

(test 3.9-right-p
  (is-true (right-p 3 4 5))
  (is-true (right-p 1.2 2.3 2.6))
  (is-false (right-p 7 6.9 9)))

(test 3.10-complexp
  (is-false (complex-p 0 0 0))
  (is-false (complex-p 1 6 4))

  (is-true (complex-p 1 2 9)))

(test 3.11-nilcar
  (is-false (nilcar nil))
  (is-true (nilcar (list 1 2 3))))

(test 3.11-nilcdr
  (is-false (nilcdr nil))
  (is-true (nilcdr (list 1 2 3))))

(test 3.12-check-temperature
  (is-true (string= "ridiculously-cold" (check-temperature -13)))
  (is-true (string= "ridiculously-hot" (check-temperature 101)))
  (is-true (string= "ok" (check-temperature 23)))
  (is-true (string= "ok" (check-temperature 0)))
  (is-true (string= "ok" (check-temperature 100))))
