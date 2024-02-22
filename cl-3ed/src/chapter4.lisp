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
