(in-package #:cl-dsa)

(defun convert-int (number-string)
  (declare (type string number-string))
  (loop
    :with str-len = (length number-string)
    :for index := 0 :then (1+ index)
    :while (< index str-len)
    :sum (* (digit-char-p (char number-string
				       (- (1- str-len) index)))
		   (expt 10 index))))
