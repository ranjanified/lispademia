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
      `(,@(last lst) ,@(butlast lst))))

(defun palindromize (lst)
  (if lst
      `(,@lst ,@(reverse lst))))

(defun f-to-c (f)
  (- (/ (+ f 40) 1.8) 40))

(defun c-to-f (c)
  (- (* (+ c 40) 1.8) 40))
