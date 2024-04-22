(in-package #:cl-dsa)

;;; Sieve of Eratosthenes
(defun sieve-primes (primes-upto)
  (unless (zerop primes-upto)
    (loop
      :initially (setf (aref primes 0) nil (aref primes 1) nil)
      :with primes := (make-array (list (1+ primes-upto)) :initial-element t)
      :for index :from 2 :upto (floor (/ primes-upto 2))
      :do (loop 
	    :for run-index :from 2 :upto (floor (/ primes-upto index))
	    :do (setf (aref primes (* index run-index)) nil))
      :finally (return (loop :for element :across primes
			     :for index :from 0
			     :when element :collect index)))))
