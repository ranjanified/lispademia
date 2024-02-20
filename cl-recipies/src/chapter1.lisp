
(defpackage :p1
  (:intern :alpha)
  (:export :bravo :charlie))

(defpackage :p2
  (:intern :alpha :delta)
  (:use :p1)
  (:export :bravo :echo))

(defpackage :p3
  (:intern :alpha)
  (:use :p2 :cl)
  (:export :charlie)
  (:import-from :p2 :delta))

(in-package :cl-recipies)

(defmacro swap (var-1 var-2)
  (let ((temp (gensym)))
       `(let ((,temp ,var-1))
	  (setf ,var-1 ,var-2 ,var-2 ,temp)
	  (values))))
