(in-package #:cl-dsa)

(defun strlen (strings)
  (declare (type (or (simple-vector *) (simple-array character *)) strings))
  (loop :for elt :across strings
	:when (char= elt #\Nul)
	  :do (return len)
	:count elt :into len
	:finally (return len)))

(defun strpos (src-str sub-str)
  (declare (type (or (simple-vector *) (simple-array character *)) src-str sub-str))
  (loop
    :named src-iterator
    :with not-found-index := -1
    :with length-src-str := (strlen src-str) :and length-sub-str := (strlen sub-str)  
    :for src-index := 0 :then (1+ src-index)
    :while (<= (+ src-index length-sub-str) length-src-str)
    :do (loop :for src-curr-index := src-index then (1+ src-curr-index)
	      :for sub-index := 0 then (1+ sub-index)
	      :while (and (< sub-index length-sub-str) (char= (elt src-str src-curr-index)
							      (elt sub-str sub-index)))
	      :when (= sub-index (1- length-sub-str))
		:do (return-from src-iterator src-index))
    :finally (return-from src-iterator not-found-index)))
