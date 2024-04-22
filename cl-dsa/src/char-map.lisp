(in-package #:cl-dsa)

(export 'char-map-depth)
(export 'make-char-map)
(export 'member-char-map)

;;; Example char-map:
;;; (let ((char-map '((#\h (#\o (#\w))
;;; 		       (#\e (#\l (#\l (#\o))))
;;; 		       (#\a (#\t)))
;;; 	          (#\b (#\a (#\t)
;;; 		            (#\g))
;;; 		       (#\o (#\x))
;;; 		       (#\i (#\t)))))
;;;       (word '(#\h (#\e (#\l (#\l (#\o)))))))))))))
(defclass char-map ()
  ((depth :accessor char-map-depth  :initform 0)
   (char-map :accessor char-map :initform (list))))

(defmethod make-char-map ((words list))
   (loop
     :with     chars-map     := (make-instance 'char-map)
     :with     map-so-far    := (list)
     :for      word          :in words
     :for      word-chars    := (word-chars word)
     :maximize (length word) :into depth
     :unless   (%member-of (char-map chars-map) word-chars)
       :do     (push word-chars (char-map chars-map))
     :finally  (setf (char-map-depth chars-map) depth)
	       (return chars-map)))

(defmethod member-char-map ((char-map char-map) (word string))
  (let ((w-chars (word-chars word)))
    (when w-chars
      (%member-of (char-map char-map) w-chars))))

(defun %word-chars (word)
  (when word
    (cond
      ((null (rest word)) (list (first word)))
      (t (list (first word) (%word-chars (rest word)))))))

(defun word-chars (word)
  (declare (type string word))
  (%word-chars (coerce word 'list)))

(defun %chars-word (chars)
  (when chars
    (cons (first chars) (%chars-word (first (rest chars))))))

(defun chars-word (chars)
  (declare (type list chars))
  (coerce (%chars-word chars) 'string))

(defun %member-of (char-map word)
  (cond
    ((null word) t)
    ((null char-map) (null word))
    (t (let ((first-match (find (first word) char-map :key #'first :test #'char=)))
	 (when first-match
	   (%member-of (rest first-match) (first (rest word))))))))
