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



(defun sexpr-p (l)
  (labels ((twist (l acc)
	     (cond
	       ((null l) acc)
	       ((atom (first l)) (twist (rest l) (cons (first l) acc)))
	       ((twist (rest l) (cons (twist (first l) (list)) acc)))))

	   (is-escapable (c) (member c (list #\. #\space #\tab)))
	   
	   (parse-list (l acc)
	     (cond
	       ((null l) acc)
	       ((atom l) l)
	       ((char= (first l) #\)) (values acc (rest l)))
	       ((is-escapable (first l)) (parse-list (rest l) acc))
	       ((char= (first l) #\() (multiple-value-bind (parsed-list remaining) (parse-list (rest l) '()) (parse-list remaining (cons parsed-list acc))))
	       (t (parse-list (rest l) (cons (first l) acc)))))

	   (is-sexpr (l)
	     (cond
	       ((null l) nil)
	       ((atom l) t)
	       ((= (length l) 2) (and (is-sexpr (first l))
				      (is-sexpr (second l)))))))
    
    (let ((parsed-list (twist (parse-list l '()) (list))))
      (cond
	((null parsed-list) nil)
	((= (length parsed-list) 1) (is-sexpr (first parsed-list)))))))
