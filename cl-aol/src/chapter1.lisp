(in-package :cl-aol)

(defun digit-p (char-digit &optional (num-base 16))
  "A | B | C | D ... | Z"
  (check-type char-digit standard-char)
  (and (digit-char-p char-digit num-base) t))

(defun atom-letter-p (atom-char)
  (check-type atom-char standard-char)
  (and (alpha-char-p atom-char) t))

(defun numeral-p (num-str &optional (num-base 16))
  "<digit> | <numeral> <digit>"
  (cond
    ((null num-str) nil)
    ((null (rest num-str)) (and (digit-p (first num-str) num-base) t))
    ((and (numeral-p (rest num-str) num-base) (digit-p (first num-str) num-base)))))


(defun literal-atom-p (char-str)
  "<literal atom> ::= <atom letter> <literal atom> (<atom letter> | <digit>)"
  (labels ((is-literal-atom (chars)
	     (cond
	       ((null chars) nil)
	       ((null (rest chars)) (or (digit-p (first chars))
					(atom-letter-p (first chars))))
	       ((and (is-literal-atom (rest chars)) (or (digit-p (first chars))
						       (atom-letter-p (first chars))))))))
    (and (atom-letter-p (first char-str))
	 (is-literal-atom (rest char-str)))))

(defun atom-p (atom-chars)
  "<atom> := <literal atom> | <numeral> | -<numeral>"
  (cond
    ((null atom-chars) t)
    ((or (literal-atom-p atom-chars)
	 (cond
	   ((char= (first atom-chars) #\-) (numeral-p (rest atom-chars)))
	   ((numeral-p atom-chars)))))))

(defun sexpr-p (l)
  (labels ((twist (l acc)
	     (cond
	       ((null l) acc)
	       ((atom (first l)) (twist (rest l) (cons (first l) acc)))
	       ((twist (rest l) (cons (twist (first l) (list)) acc)))))

	   (is-escapable (c) (member c (list #\. #\space #\tab)))

	   (nil-p (l)
	     (and (and (not (null (first l)))
			  (or (char= (first l) #\N)
			      (char= (first l) #\n)))
		     (and (not (null (second l)))
			  (or (char= (second l) #\I)
			      (char= (second l) #\i)))
		     (and (not (null (third l)))
			  (or (char= (third l) #\L)
			      (char= (third l) #\l)))))
	   
	   (parse-list (l acc)
	     (cond
	       ((null l) acc)
	       ((atom l) l)
	       ((char= (first l) #\)) (values acc (rest l)))
	       ((is-escapable (first l)) (parse-list (rest l) acc))
	       ((char= (first l) #\() (multiple-value-bind (parsed-list remaining) (parse-list (rest l) (list)) (parse-list remaining (cons parsed-list acc))))
	       ((nil-p l) (parse-list (nthcdr 3 l) (cons nil acc)))
	       (t (parse-list (rest l) (cons (first l) acc)))))

	   (is-sexpr (l)
	     (cond
	       ;; ((null l) t)
	       ((atom l) t)
	       ((= (length l) 2) (and (is-sexpr (first l))
				      (is-sexpr (second l)))))))
    
    (let ((parsed-list (twist (parse-list l '()) (list))))
      (cond
	((null parsed-list) nil)
	((= (length parsed-list) 1) (is-sexpr (first parsed-list)))))))

(defun identifier-p (l)
  (labels ((identifier-rec-p (l)
	     (cond
	       ((null l) t)
	       ((atom-letter-p (first l)) (identifier-rec-p (rest l)))
	       ((digit-p (first l)) (identifier-rec-p (rest l))))))
    (cond
      ((null l) nil)
      ((identifier-rec-p l)))))
