(in-package #:cl-3ed)

(defun first (lst)
  (car lst))

(defun rest (lst)
  (cdr lst))

(defun insert (ele lst)
  (cons ele lst))
