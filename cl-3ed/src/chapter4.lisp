(in-package #:cl-3ed)

;; 4.1
(defun mystery (s)
  (cond
    ((null s) 1)
    ((atom s) 0)
    (t (max (1+ (mystery (first s))) (mystery (rest s))))))

;; 4.2
(defun strange (l)
  (cond
    ((null l) nil)
    ((atom l) l)
    (t (cons (strange (first l))
	     (strange (rest l))))))

;; 4.3
(defun squash (lst)
  (cond
    ((null lst) nil)
    ((atom (first lst)) (cons (first lst) (squash (rest lst))))
    (t (append (squash (first lst)) (squash (rest lst))))))

;; 4.4
(defun fibonacci (fib-index)
  (loop
    :for count :from 1
    :for fib0 := 0 :then fib1
    :for fib1 := 1 :then curr-fib
    :for curr-fib := fib0 :then (+ fib0 fib1)
    :maximize curr-fib
    :while (> fib-index count)))
