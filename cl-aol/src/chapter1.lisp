(in-package :cl-aol)

(defun digit-p (n)
  ""
  (check-type n standard-char)
  (and (char>= n #\0) (char<= n #\9)))

(defun numeral-p (l)
  "<digit> | <numeral> <digit>"
  (labels
      ((is-it (l)
	 (cond
	   ((null l) t)
	   ((and (digit-p (first l)) (is-it (rest l)))))))
    (cond
      ((null l) nil)
      ((is-it l)))))

(defun atom-letter-p (l)
  ""
  ;; built-in: alpha-char-p
  (declare (type standard-char l))
  (or (and (char>= l #\a) (char<= l #\z))
      (and (char>= l #\A) (char<= l #\Z))))

(defun literal-atom-p (l)
  ""
  (labels ((is-it (l)
	     (cond
	       ((null l) t)
	       ((atom-letter-p (first l)) (is-it (rest l)))
	       ((digit-p (first l)) (is-it (rest l))))))
    (cond
      ((null l) nil)
      ;; first one has to be a letter
      ((atom-letter-p (first l)) (is-it l)))))

(defun atom-p (l)
  "<atom> := <literal atom> | <numeral> | -<numeral>"
  (cond
    ((null l) t)
    ((or (literal-atom-p l)
	 (cond
	   ((char= (first l) #\-) (numeral-p (rest l)))
	   ((numeral-p l)))))))
