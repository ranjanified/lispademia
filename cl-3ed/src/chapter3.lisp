(in-package #:cl-3ed)

(defun first (lst)
  (car lst))

(defun rest (lst)
  (cdr lst))

(defun insert (ele lst)
  (cons ele lst))

(defun rotate-l (lst)
  (if lst
      (append (rest lst) (list (first lst)))))

(defun rotate-r (lst)
  (if lst
      `(,@ (last lst) ,@(butlast lst))))
