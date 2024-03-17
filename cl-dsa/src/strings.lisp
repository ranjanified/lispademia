(in-package #:cl-dsa)

(defun strlen (strings)
  (declare (type (or (simple-vector *) (simple-array character *)) strings))
  (if (> (first (array-dimensions strings)) 0)
    (do ((i 0 (1+ i)))
	((char= (elt strings i) #\Nul) i))
    0))

(defun strpos (string1 string2)
  (declare (type (or (simple-vector *) (simple-array character *)) string1 string2))
  (if (and (> (first (array-dimensions string1)) 0) (> (first (array-dimensions string2)) 0))
      (progn
	(loop
	  :with length-1 := (strlen string1) :and length-2 := (strlen string2)  
	  :for string1-index := 0 :then (1+ string1-index)
	  :while (<= (+ string1-index length-2) length-1)
	  :do (progn
		(loop :for string1-curr-index := string1-index then (1+ string1-curr-index)
		      :for string2-index := 0 then (1+ string2-index)
		      :while (and (< string2-index length-2) (char= (elt string1 string1-curr-index)(elt string2 string2-index)))
		      :when (= string2-index (1- length-2)) :do (return-from strpos string1-index))))
	-1)
      -1))
