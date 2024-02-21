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
