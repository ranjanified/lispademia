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
