(in-package :cl-aol)

(defun is-digit (n)
  ""
  ;; (declare (type fixnum n))
  (check-type n standard-char)
  (and (char>= n #\0) (char<= n #\9)))

(defun is-numeral (l)
  ""
  (labels
      ((is-it (l)
	 (cond
	   ((null l) t)
	   ((and (is-digit (car l)) (is-it (cdr l)))))))
    (cond
      ((null l) nil)
      ((is-it l)))))

(defun is-letter (l)
  ""
  ;; built-in: alpha-char-p
  (declare (type standard-char l))
  (or (and (char>= l #\a) (char<= l #\z))
      (and (char>= l #\A) (char<= l #\Z))))

(defun is-literal (l)
  ""
  (labels ((is-it (l)
	     (cond
	       ((null l) t)
	       ((is-letter (car l)) (is-it (cdr l)))
	       ((is-digit (car l)) (is-it (cdr l))))))
    (cond
      ((null l) nil)
      ((is-it l)))))
