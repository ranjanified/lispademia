(in-package #:cl-dsa)

(defun median (stats)
  (declare (type (simple-array (integer * *) (*)) stats))
  (let ((sorted (stable-sort stats #'<)))
    (unless (zerop (length sorted))
      (if (evenp (length sorted))
	  (/ (+ (svref stats (1- (/ (length stats) 2))) (svref stats (/ (length stats) 2))) 2)
	  (svref sorted (1- (/ (1+ (length sorted)) 2)))))))

(defun mode (stats)
  (declare (type (simple-array (integer * *) (*)) stats))
  ;;; prepare an assoc list of (count . element) pair, then scan for mode in the assoc list
  (loop :with table := (list)
	:for s :across stats
	:for entry := (rassoc s table)
	:unless entry 
	  :do (push (cons 1 s) table)
	:when entry
	  :do (incf (first entry))
	:finally (return (when (> (length stats) 0)
			   (loop
			     ;;; find maximum count appearing in the table
			     :with max-count := (loop :for table-item :in table :maximize (first table-item)) 
			     :for item :in table
			     :when (= max-count (first item))
			       :collect item :into items-coll
			     :finally (return
					;; return mode when there is only one entry for an element with max count
					(unless (> (list-length items-coll) 1) 
					  (destructuring-bind (c . v) (first items-coll)
					    (declare (ignore c)) 
					    v))))))))
