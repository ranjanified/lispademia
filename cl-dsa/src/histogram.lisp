(in-package #:cl-dsa)

(defun print-histogram-vertical (item-counts)
  (terpri)
  (loop repeat 1
	with max-lines = (loop for l across item-counts maximize l)
	do (loop for curr-line from max-lines downto 1
		 do (loop for item-len across item-counts
			  when (<= curr-line item-len)
			    do (princ (make-string 3 :initial-element #\*)) (princ (make-string 2 :initial-element #\Space))
			  else do (princ (make-string 5 :initial-element #\Space)))
		 do (terpri))))
