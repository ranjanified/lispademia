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

(defun roots (a b c)
  (if (zerop a)
      (values 0.0 0.0)
      (let ((b^2-4ac (- (* b b) (* 4 a c))))
	(values (/ (+ (- b) (sqrt b^2-4ac)) (* 2 a))
		(/ (- (- b) (sqrt b^2-4ac)) (* 2 a))))))

;; 3.7
(defun evenp (num)
  (zerop (rem num 2)))

;; 3.8
(defun palindrome-p (lst)
  (eval `(and ,@(mapcar (lambda (a b) (eql a b)) lst (reverse lst)))))

;; 3.9
(defun right-p (side1 side2 side3)
  (let* ((sorted (sort (list side1 side2 side3) #'<))
	 (f-shortest (first sorted))
	 (s-shortest (second sorted))
	 (longest (first (last sorted)))
	 (shortest-square (+ (* f-shortest f-shortest)
			     (* s-shortest s-shortest)))
	 (longest-square (* longest longest)))
    (<= (/ (* 100 (abs (- longest-square shortest-square)))
	   longest-square)
	2)))
