(in-package #:cl-3ed)

(defun mystery (s)
  (cond
    ((null s) 1)
    ((atom s) 0)
    (t (max (1+ (mystery (first s))) (mystery (rest s))))))
