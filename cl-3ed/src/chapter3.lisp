(in-package #:cl-3ed)

;; 3.1
(defun first (lst)
  (car lst))

;; 3.1
(defun rest (lst)
  (cdr lst))

;; 3.1
(defun insert (ele lst)
  (cons ele lst))

;; 3.2
(defun rotate-l (lst)
  (if lst
      (append (rest lst) (list (first lst)))))

;; 3.3
(defun rotate-r (lst)
  (if lst
      `(,@(last lst) ,@(butlast lst))))

;; 3.4
(defun palindromize (lst)
  (if lst
      `(,@lst ,@(reverse lst))))

;; 3.5
(defun f-to-c (f)
  (- (/ (+ f 40) 1.8) 40))

;; 3.5
(defun c-to-f (c)
  (- (* (+ c 40) 1.8) 40))

;; 3.6
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

;; 3.10
(defun complex-p (a b c)
  (minusp (- (* b b) (* 4 a c))))

;; 3.11
(defun nilcar (lst)
  (if lst (car lst)))

;; 3.11
(defun nilcdr (lst)
  (if lst (cdr lst)))

;; 3.12
(defun check-temperature (temp)
    (cond
      ((> temp 100) "ridiculously-hot")
      ((< temp 0) "ridiculously-cold")
      (t "ok")))

;; 3.13
(defun circle (radius)
  (list (* 2 (symbol-value 'pi) radius)
	(* (symbol-value 'pi) (* radius radius))))
