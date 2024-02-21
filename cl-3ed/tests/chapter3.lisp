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
