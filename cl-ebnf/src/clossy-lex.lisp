(in-package #:cl-ebnf)

(defmacro with-whitespace-chars ((&rest whitespace-chars) &body body)
  `(progv '(dynamic-whitespace-chars) '(,whitespace-chars)
     ,@body))

(defmacro with-meta-characters ((&rest meta-characters) &body body)
  `(progv '(dynamic-meta-chars) '(,meta-characters)
     ,@body))

(defgeneric clossy-lex (token-source))

(defmethod clossy-lex ((token-source string))
  (declare (special dynamic-whitespace-chars dynamic-meta-chars))
  (with-input-from-string (token-stream token-source)
    (loop
      :with meta-chars := (or (and (boundp 'dynamic-meta-chars) dynamic-meta-chars)
			      (list +repetition-symbol+
				    +except-symbol+
				    +concatenate-symbol+
				    +definition-separator-symbol-1+
				    +defining-symbol+
				    +terminator-symbol-1+ +terminator-symbol-2+
				    +first-quote-symbol+ +second-quote-symbol+
				    +start-group-symbol+ +end-group-symbol+
				    +start-repeat-symbol+ +end-repeat-symbol+
				    +start-option-symbol+ +end-option-symbol+
				    +special-sequence-symbol+))
      :with whitespace-chars := (or (and (boundp 'dynamic-whitespace-chars) dynamic-whitespace-chars)
				    (list #\Space #\Newline #\Return #\Linefeed #\Vt #\Page))
      :with identifier-chars := (list)
      :for token-char := (read-char token-stream nil)
      :for meta-symbol-p := (and token-char (member token-char meta-chars :test #'char=) t)
      :and  whitespace-char-p := (and token-char (member token-char whitespace-chars :test #'char=) t)
      :for identifier := (and meta-symbol-p identifier-chars (make-identifier identifier-chars))
      :while token-char
      :when (and meta-symbol-p identifier (string-not-equal (second identifier) ""))
	:collect identifier :into token-list
	:and :do (setf identifier-chars (list))
      :when meta-symbol-p
	:collect (lex-meta-character token-char token-stream) :into token-list
      :else
	:do (push (if whitespace-char-p #\Space token-char) identifier-chars)
      :finally (return (let ((trailing-identifier (make-identifier identifier-chars)))
			 (append token-list
				 (and trailing-identifier (list trailing-identifier))))))))

(defun make-identifier (id-chars)
  (when id-chars
    (let ((id-str (string-trim '(#\Space) (coerce (reverse id-chars) 'string))))
      (when (string-not-equal id-str "")
	(list :identifier id-str)))))

(defgeneric lex-meta-character (meta-char token-stream))
(defmethod lex-meta-character ((meta-char (eql +repetition-symbol+)) (token-stream stream))
  (list :repetition-symbol))

(defmethod lex-meta-character ((meta-char (eql +except-symbol+)) (token-stream stream))
  (list :except-symbol))

(defmethod lex-meta-character ((meta-char (eql +concatenate-symbol+)) (token-stream stream))
  (list :concatenate-symbol))

(defmethod lex-meta-character ((meta-char (eql +definition-separator-symbol-1+)) (token-stream stream))
  (list :definition-separator-symbol))

(defmethod lex-meta-character ((meta-char (eql +defining-symbol+)) (token-stream stream))
  (list :definition-symbol))

(defmethod lex-meta-character ((meta-char (eql +terminator-symbol-1+)) (token-stream stream))
  (list :terminator-symbol))

(defmethod lex-meta-character ((meta-char (eql +terminator-symbol-2+)) (token-stream stream))
  (list :terminator-symbol))

(defmethod lex-meta-character ((meta-char (eql +first-quote-symbol+)) (token-stream stream))
  (list :first-quote-symbol))

(defmethod lex-meta-character ((meta-char (eql +second-quote-symbol+)) (token-stream stream))
  (list :second-quote-symbol))

(defmethod lex-meta-character ((meta-char (eql +start-group-symbol+)) (token-stream stream))
  (list :group-start-symbol))

(defmethod lex-meta-character ((meta-char (eql +end-group-symbol+)) (token-stream stream))
  (list :group-end-symbol))

(defmethod lex-meta-character ((meta-char (eql +start-repeat-symbol+)) (token-stream stream))
  (list :repeat-start-symbol))

(defmethod lex-meta-character ((meta-char (eql +end-repeat-symbol+)) (token-stream stream))
  (list :repeat-end-symbol))

(defmethod lex-meta-character ((meta-char (eql +start-option-symbol+)) (token-stream stream))
  (list :option-start-symbol))

(defmethod lex-meta-character ((meta-char (eql +end-option-symbol+)) (token-stream stream))
  (list :option-end-symbol))

(defmethod lex-meta-character ((meta-char (eql +special-sequence-symbol+)) (token-stream stream))
  (list :special-sequence-symbol))
