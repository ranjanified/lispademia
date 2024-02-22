(in-package #:cl-3ed/tests)

(in-suite* chapter4 :in cl-3ed-suite)

(test 4.1-mystery
  (is-true (= 1 (mystery nil)))
  (is-true (= 1 (mystery (list 1))))
  (is-true (= 2 (mystery (list nil nil))))
  (is-true (= 1 (mystery (list 1 2 3 4 5))))
  (is-true (= 2 (mystery (list 1 (list 2)))))
  (is-true (= 3 (mystery '(((a b) c) d))))
  (is-true (= 4 (mystery '(((a b)) (c d) ((e (f))))))))

;; looks like a tree walker
(test 4.2-strange
  (is-true (null (strange nil)))
  (is-true (zerop (strange 0)))
  (is-true (equal (list 0) (strange (list 0))))
  (is-true (equal (list 0 1 2 3) (strange (list 0 1 2 3))))
  (is-true (equal (list 1 (list 2 3) (list (list 4 5))) (strange (list 1 (list 2 3) (list (list 4 5)))))))

(test 4.3-squash
  (is-true (null (squash nil)))
  (is-true (equal (list nil) (squash (list nil))))
  (is-true (equal (list 1 2 3) (squash (list 1 2 3))))
  (is-true (equal (list 1 2 3 4) (squash (list 1 (list 2 3) (list 4)))))
  (is-true (equal (list 1 2 3 4 5 6 7) (squash (list (list (list (list 1 2 3))) (list (list 4 5) (list 6 7)))))))

(test 4.4-fibonacci
  (is-true (zerop (fibonacci 0)))
  (is-true (zerop (fibonacci 1)))
  (is-true (= 1 (fibonacci 2)))
  (is-true (= 1 (fibonacci 3)))
  (is-true (= 2 (fibonacci 4)))
  (is-true (= 3 (fibonacci 5)))
  (is-true (= 5 (fibonacci 6)))
  (is-true (= 8 (fibonacci 7)))
  (is-true (= 13 (fibonacci 8)))
  (is-true (= 21 (fibonacci 9))))

(test 4.5-union
  (is-true (null (union nil nil)))
  (is-true (equal (list nil) (union nil (list nil))))
  (is-true (equal (list nil) (union (list nil) nil)))
  (is-true (equal (list 1) (union nil (list 1))))
  (is-true (equal (list 1) (union (list 1) nil)))
  (is-true (equal (list 1) (union (list 1) (list 1))))
  (is-true (equal (list 1 4 5 3 2 6) (union (list 1 3 2 4) (list 5 3 2 6))))
  (is-true (equal (list 1 2 (list 3 4) 3 4 (list 5 6)) (union (list 1 2 (list 3 4)) (list 3 4 (list 5 6)))))
  (is-true (equal (list 2 1 (list 3 4) 5 6) (union (list 1 2 (list 3 4)) (list 2 1 (list 3 4) 5 6))))
  (is-true (equal (list (list (list))) (union (list (list (list))) (list (list (list)))))))
