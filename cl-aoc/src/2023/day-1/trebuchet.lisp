(in-package :cl-aoc)
(export 'trebuchet)

(defun trebuchet (calibration-values)
  (labels ((make-two-digit-number (tens-digit ones-digit)
	     (parse-integer (coerce (list tens-digit ones-digit) 'string)))

	   (read-calibration-value (value-string)
	     (let ((potential-digits (remove-if #'null (coerce value-string 'list) :key (lambda (c) (digit-char-p c)))))
	       (cond
		 ((null potential-digits) 0)
		 (t (make-two-digit-number (first potential-digits)
					   (first (last potential-digits))))))))
    (cond
      ((null calibration-values) 0)
      (t (reduce #'+ calibration-values :key #'read-calibration-value :initial-value 0)))))
