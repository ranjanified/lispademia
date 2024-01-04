(in-package :cl-exercises)

(export 'print-numbers)
(export 'print-odd-numbers-between)
(export 'print-multiplication-table-of)
(export 'sum-between)
(export 'calculate-factorial)
(export 'sum-evens-between)
(export 'celsius-fahrenheit)
(export 'fahrenheit-celsius)
(export 'sum-num-array)

(defun print-numbers (from to)
  (loop for i :from from :to to
	do (print i)))

(defun print-odd-numbers-between (from to)
  (loop for i :from from :to to
	when (oddp i) do (print i)))

(defun print-multiplication-table-of (table-of)
  (terpri)
  (loop for times :from 1 :to 10
	for res := table-of then (* times table-of)
	with formatter := "~a~2@t~c~2@t~a~2@t~c~2@t~a"
	with last-formatter := "~a~2@t~c~2@t~a~@t~c~2@t~a"
	do (princ (format nil (if (= 10 times) last-formatter formatter) table-of #\x times #\= res))
	   (terpri)))

(defun sum-between (from to)
  ;; This can also be solved using a formula for summing an Arithmetic Progression series of numbers
  (loop for num :from from :to to
	sum num))

(defun calculate-factorial (num)
  (loop for fact-num :from num :downto 1
	for fact-res := fact-num then (* fact-num fact-res)
	finally (return fact-res)))

(defun sum-evens-between (from to &key (exclude-to t))
  (loop for num :from from :to (if exclude-to (1- to) to)
	when (evenp num) sum num))

(defun celsius-fahrenheit (cel)
  (+ (/ (* cel 9.0) 5.0) 32))

(defun fahrenheit-celsius (fah)
  (/ (* 5.0 (- fah 32)) 9.0))

(defun sum-num-array (num-arr)
  (loop for num :across num-arr
	sum num))
