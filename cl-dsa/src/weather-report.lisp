(in-package #:cl-dsa)

(defun weather-report (readings)
  ;; (declare (type (simple-array (simple-array (or (integer -90 -1) (integer 1 90) (single-float)) 2) *) readings))
  (prog* ((average-of-averages (lambda (averages)
				 (loop :for s :across averages
				       :when s
					 :sum s :into sum-sum :and :count s :into count-count
				       :finally (return (if (zerop count-count) nil (float (/ sum-sum count-count)))))))
	 (average-readings (lambda (readings) (loop :for r :across readings
						    :sum r :into sum
						    :count r :into count
						    :finally (return (if (zerop count) nil (float (/ sum count)))))))
	 (northern-readings (make-array '(90)
			     :initial-contents
			     (loop :repeat 90
				   :collect (make-array '(90) :adjustable t :fill-pointer 0 :initial-element (list)))))
	 (southern-readings (make-array '(90)
			     :initial-contents
			     (loop :repeat 90
				   :collect (make-array '(90) :adjustable t :fill-pointer 0 :initial-element (list)))))
	 (average-readings-table (make-array '(90 3) :initial-contents (loop :repeat 90 :collect (vector nil nil nil))))
	 (calculate-warmer (lambda (readings-table)
			     (loop
			       :for index :from 0 :below (array-dimension readings-table 0)
			       :when (and (aref readings-table index 0)
					  (aref readings-table index 1))
				 :collect (aref readings-table index 0) :into n-averages
				 :and :collect (aref readings-table index 1) :into s-averages
			       :finally (return (let ((n-avg (funcall average-of-averages (coerce n-averages 'simple-vector)))
						      (s-avg (funcall average-of-averages (coerce s-averages 'simple-vector))))
						  (vector n-avg
							  s-avg
							  (when (and n-avg s-avg)
							    (if (> n-avg s-avg)
								"northern hemisphere"
								"southern hemisphere")))))))))
     ;; filter readings in northern and southern buckets
     (loop :for reading :across readings
	   :do (vector-push (svref reading 1)
			    (aref (if (plusp (svref reading 0))
				      northern-readings
				      southern-readings)
				  (1- (abs (svref reading 0))))))
     ;; Calculate of averages of each latitude in their respective buckets
     (loop
       :for index := 1 :then (1+ index)
       :for northern-reading :across northern-readings
       :for southern-reading :across southern-readings
       :unless (zerop (length northern-reading))
	 :do (setf (aref average-readings-table (1- index) 0) (funcall average-readings northern-reading))
       :unless (zerop (length southern-reading))
	 :do (setf (aref average-readings-table (1- index) 1) (funcall average-readings southern-reading))
       :do (setf (aref average-readings-table (1- index) 2) (funcall average-of-averages
								     (vector (aref average-readings-table (1- index) 0)
									     (aref average-readings-table (1- index) 1)))))
     ;; Print the table and warmer hemisphere info
     (loop
       :initially (format t "~&~:(~2@a~)~t~:(~16@a~)~t~:(~16@a~)~t~:(~16@a~)~&"
			  "latitude" "northern hemisphere" "southern hemisphere" "average-readings")
       :for index :from 0 :below (array-dimension average-readings-table 0)
       :do (format t "~2@a.~t~:@(~18@a~)~:@(~18@a~)~:@(~18@a~)~&"
		   (1+ index)
		   (or (aref average-readings-table index 0) "no data")
		   (or (aref average-readings-table index 1) "no data")
		   (or (aref average-readings-table index 2) "no data"))
       :finally (let  ((calculated (funcall calculate-warmer average-readings-table)))
		  (format t "Northern Average:~t~:@(~a~)~&Southern Average:~t~:@(~a~)~&Warmer~16t:~t~:@(~a~)~&"
			  (or (svref calculated 0) "not available")
			  (or (svref calculated 1) "not available")
			  (if (= (or (svref calculated 0) 0)
				 (or (svref calculated 1) 0))
			      "both hemispheres are equally warm"
			      (or (svref calculated 2) "not available")))))))
