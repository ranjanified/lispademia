(in-package #:cl-dsa)

(defun strlen (strings)
  (declare (type (or (simple-vector *) (simple-array character *)) strings))
  (if (> (first (array-dimensions strings)) 0)
    (do ((i 0 (1+ i)))
	((char= (elt strings i) #\Nul) i))
    0))

(defun strpos (src-str sub-str)
;;  (declare (type (or (simple-vector *) (simple-array character *)) src-str sub-str))
  (progn
    (when (and (> (first (array-dimensions src-str)) 0)
	       (> (first (array-dimensions sub-str)) 0))
      (loop
	:with length-src-str := (strlen src-str) :and length-sub-str := (strlen sub-str)  
	:for src-index := 0 :then (1+ src-index)
	:while (<= (+ src-index length-sub-str) length-src-str)
	:do (loop :for src-curr-index := src-index then (1+ src-curr-index)
		  :for sub-index := 0 then (1+ sub-index)
		  :while (and (< sub-index length-sub-str) (char= (elt src-str src-curr-index)
								  (elt sub-str sub-index)))
		  :when (= sub-index (1- length-sub-str)) :do (return-from strpos src-index)))))
  -1)
