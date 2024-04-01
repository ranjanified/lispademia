(in-package #:cl-ebnf)

(defgeneric lex (token-source))

(defmethod lex ((token-source string))
  ;; with variables to track mandatory balanced lexicons
  (progv '(group-level option-level repeat-level special-sequence-level) '(0 0 0 0)  
    (with-input-from-string (token-stream token-source)
      (let ((*readtable* (copy-readtable nil)))
	(setf (readtable-case *readtable*) :preserve)
	(set-macro-character #\LEFT_PARENTHESIS #'read-possibly-corg)
	(set-macro-character +start-option-symbol+ #'read-option)
	(set-macro-character +concatenate-symbol+ #'read-concatenate-symbol)
	(set-macro-character +start-repeat-symbol+ #'read-repeat)
	(set-macro-character +special-sequence-symbol+ #'read-special-sequence)
	(set-macro-character +terminator-symbol-1+ #'read-terminator-symbol)
	(set-macro-character +terminator-symbol-2+ #'read-terminator-symbol)
	(set-macro-character +repetition-symbol+ #'read-repetition-symbol)
	(set-macro-character +except-symbol+ #'read-except-symbol)
	(set-macro-character +defining-symbol+ #'read-defining-symbol)
	(set-macro-character +definition-separator-symbol-1+ #'read-definition-separator-symbol)
	(set-macro-character +definition-separator-symbol-2+ #'read-definition-separator-symbol)
	(set-macro-character +definition-separator-symbol-3+ #'read-definition-separator-symbol)
	(set-macro-character +first-quote-symbol+ #'read-quoted-symbol)
	(set-macro-character +second-quote-symbol+ #'read-quoted-symbol)
	
	(let ((tokens (lex-stream token-stream *readtable*)))
	  (locally (declare (special group-level option-level repeat-level special-sequence-level))
	    (assert-malformed-token group-level :token-type :ebnf-group)
	    (assert-malformed-token option-level :token-type :ebnf-option)
	    (assert-malformed-token repeat-level :token-type :ebnf-repeat)
	    (assert-malformed-token special-sequence-level :token-type :ebnf-special-sequence)
	    tokens))))))

(defun lex-stream (token-stream with-readtable)
  (let ((*readtable* (copy-readtable with-readtable)))
    (loop
      :for next-token := (read token-stream nil nil)
      :until (null next-token)
      :if (listp next-token)
	:collect next-token
      :else
	:collect (list :unknown (format nil "~a" next-token)))))


(defun read-possibly-corg (stream chr)
  (let ((next-char (peek-char nil stream nil)))
    (cond 
      ((char= next-char +start-comment-symbol-2+) (read-char stream nil) (read-comment stream))
      ((char= next-char +start-option-symbol-2+) (read-char stream nil) (read-option stream chr))
      ((char= next-char +start-repeat-symbol-2+) (read-char stream nil) (read-repeat stream chr))
      (t (read-group stream)))))

(defun read-option (stream chr)
  (declare (special option-level)
	   (ignore chr))
  (let ((*readtable* (copy-readtable *readtable*)))
    (set-macro-character +end-option-symbol-1+ #'read-option-end)
    (set-macro-character +end-option-symbol+ #'read-option-end)
    (set-macro-character +end-option-symbol-2+ nil)
    (incf option-level)
    (list :option (lex-stream stream *readtable*))))

(defun read-option-end (stream chr)
  (declare (special option-level))
  (cond
    ((char= chr +end-option-symbol+) (decf option-level) nil)
    ((char= chr +end-option-symbol-1+) (let ((next-char (peek-char nil stream nil)))
					 (if (and next-char (char= next-char +end-option-symbol-2+))
					     (and (decf option-level) (and (read-char stream) nil))
					     chr)))
    (t chr)))

(defun read-repeat (stream chr)
  (declare (ignore chr)
	   (special repeat-level))
  (let ((*readtable* (copy-readtable *readtable*)))
    (set-macro-character +end-repeat-symbol-1+ #'read-repeat-end)
    (set-macro-character +end-repeat-symbol+ #'read-repeat-end)
    (set-macro-character +end-repeat-symbol-2+ nil)
    (incf repeat-level)
    (list :repeat (lex-stream stream *readtable*))))

(defun read-repeat-end (stream chr)
  (declare (special repeat-level))
  (cond
    ((char= chr +end-repeat-symbol+) (decf repeat-level) nil)
    ((char= chr +end-repeat-symbol-1+) (let ((next-char (peek-char nil stream nil)))
					 (if (and next-char (char= next-char +end-repeat-symbol-2+))
					     (and (decf repeat-level)
						  (and (read-char stream) nil))
					     chr)))
    (t chr)))

(defun read-group (stream)
  (declare (special group-level))
  (let ((*readtable* (copy-readtable *readtable*)))
    (set-macro-character +end-group-symbol+ #'read-group-end nil *readtable*)
    (incf group-level)
    (list :group (lex-stream stream *readtable*))))

(defun read-group-end (stream chr)
  (declare (ignore stream chr)
	   (special group-level))
  (decf group-level)
  nil)

(defun read-comment (stream)
  (list :comment (loop :for comment-char := (read-char stream)
		       :for found-end-comment := (and comment-char
						      (and (char= comment-char +end-comment-symbol-1+)
							   (let ((next-char (peek-char nil stream nil)))
							     (and next-char
								  (char= next-char +end-comment-symbol-2+))))) 
		       :until (or (not comment-char) found-end-comment)
		       :when comment-char
			 :collect comment-char :into comments
		       :finally (if comment-char (read-char stream))
				(return (coerce comments 'string)))))

(defun read-quoted-symbol (stream chr)
  (list :quoted-symbol
	(loop
	  :for curr-char := (read-char stream nil)
	  :while curr-char
	  :until (char= chr curr-char)
	    :collect curr-char :into quoted-symbols
	  :finally (unless curr-char (error 'malformed-token :token-type :quoted-symbol)) ; loop terminated due to end of stream
		   ;; loop terminated due to matching quote found
		   (return (coerce quoted-symbols 'string)))))

(defun read-special-sequence (stream chr)
  (declare (special special-sequence-level)
	   (ignore chr))
  (cond
    ((zerop special-sequence-level) (incf special-sequence-level) (list :special-sequence (lex-stream stream *readtable*)))
    (t (decf special-sequence-level) nil)))

(defun read-concatenate-symbol (stream chr)
  (declare (ignore stream chr))
  (list :concatenate))

(defun read-terminator-symbol (stream chr)
  (declare (ignore stream chr))
  (list :terminator))

(defun read-repetition-symbol (stream chr)
  (declare (ignore stream chr))
  (list :repetition))

(defun read-except-symbol (stream chr)
  (declare (ignore stream chr))
  (list :exception))

(defun read-defining-symbol (stream chr)
  (declare (ignore stream chr))
  (list :definition))

(defun read-definition-separator-symbol (stream chr)
  (declare (ignore stream chr))
  (list :definition-separator))

(defun assert-malformed-token (bal-val &key token-type)
  (assert (zerop bal-val) (bal-val) 'malformed-token :token-type token-type))
