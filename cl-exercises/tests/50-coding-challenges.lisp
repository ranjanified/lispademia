;;;; https://codeguppy.com/site/download/50_coding_challenges.pdf

(in-package :cl-exercises/tests)

;; (def-suite print-numbers-tests :in cl-exercises-tests)
(in-suite* :cl-exercises-tests)

;; Print Numbers from 1 to 10
(test print-numbers-1-10
      (finishes (print-numbers 1 10)))

;; Print the odd numbers less than 100
(test print-odd-numbers-less-than-100
  (finishes (print-odd-numbers-between 0 100)))

;; Print the multiplication table with 7
(test print-multiplication-table-of-7
  (finishes (print-multiplication-table-of 7)))

;; Print all the multiplication tables with numbers from 1 to 10
(test print-all-multiplication-tables-from-1-to-10
    (finishes (loop for i :from 1 :to 10
		    do (print-multiplication-table-of i))))

;; Calculate the sum of numbers from 1 to 10
(test sum-numbers-between-1-to-100
  (is (= 5050 (sum-between 1 100))))

;; Calculate 10!
(test calculate-factorial-of-10
  (is (= 3628800 (calculate-factorial 10))))

;; Calculate the sum of even numbers greater than 10 and less than 30
(test sum-evens-between-10-and-30
  (is (= 190 (sum-evens-between 10 30))))

;; Create a function that will convert from Celsius to Fahrenheit
(test celsius-to-fahrenheit
  (is (= 99.5 (celsius-fahrenheit 37.5))))

;; Create a function that will convert from Fahrenheit to Celsius
(test fahrenheit-to-celsius
  (is (= 37.5 (fahrenheit-celsius 99.5))))

;; Calculate the sum of numbers in an array of numbers
(test sum-number-array
  (is (= 15 (sum-num-array #(1 2 3 4 5)))))

;; Calculate the average of the numbers in an array of numbers
(test average-number-array-test
      (is (= 5.5 (average-number-array #(1 2 3 4 5 6 7 8 9 10)))))

;; Create a function that receives an array of numbers as argument and returns an array containing only the positive numbers
(test filter-positives-from-array
  (is-true (let* ((num-array #(2 -3 4 -9 -7 6))
		  (positives (filter-positives num-array)))
	     (and (arrayp positives) (equalp positives #(2 4 6))))))

;; Find the maximum number in an array of numbers
(test max-in-array
  (is (= 90 (max-array #(1 13 65 88 6 7 90 65)))))

;; Print the first 10 Fibonacci numbers without recursion
(test print-fibonacci-first-10
  (finishes (print-fibonacci 10)))

;; Create a function that will find the nth Fibonacci number using recursion
(test nth-fibonacci-number
  (is-true (zerop (nth-fibonacci 0)))
  (is (= 1 (nth-fibonacci 1)))
  (is (= 1 (nth-fibonacci 2)))
  (is (= 2 (nth-fibonacci 3)))
  (is (= 3 (nth-fibonacci 4)))
  (is (= 5 (nth-fibonacci 5)))
  (is (= 8 (nth-fibonacci 6)))
  (is (= 13 (nth-fibonacci 7)))
  (is (= 21 (nth-fibonacci 8)))
  (is (= 34 (nth-fibonacci 9)))
  (is (= 55 (nth-fibonacci 10)))
  (is (= 89 (nth-fibonacci 11)))
  (is (= 144 (nth-fibonacci 12)))
  (is (= 233 (nth-fibonacci 13)))
  (is (= 377 (nth-fibonacci 14)))
  (is (= 610 (nth-fibonacci 15)))
  (is (= 987 (nth-fibonacci 16)))
  (is (= 1597 (nth-fibonacci 17)))
  (is (= 2584 (nth-fibonacci 18)))
  (is (= 4181 (nth-fibonacci 19)))
  (is (= 6765 (nth-fibonacci 20))))

;; Create a function that will return a Boolean specifying if a number is prime
(test test-prime
  (is-false (prime-p 0))
  (is-false (prime-p 1))
  (is-true (prime-p 2))
  (is-true (prime-p 3))
  (is-false (prime-p 4))
  (is-true (prime-p 5))
  (is-false (prime-p 6))
  (is-true (prime-p 7))
  (is-false (prime-p 8))
  (is-false (prime-p 9))
  (is-false (prime-p 10))
  (is-true (prime-p 11))
  (is-false (prime-p 12))
  (is-true (prime-p 13))
  (is-false (prime-p 14))
  (is-false (prime-p 15))
  (is-false (prime-p 16))
  (is-true (prime-p 17))
  (is-false (prime-p 18))
  (is-true (prime-p 19))
  (is-false (prime-p 20)))

;; Calculate the sum of digits of a positive integer number
(test sum-of-digits-of-a-number
  (is-true (zerop (sum-digits 0)))
  (is (= 8 (sum-digits 8)))
  (is (= 16 (sum-digits 772)))
  (is (= 26 (sum-digits 998)))
  (is (= 10 (sum-digits 102034))))

;; Print the first 100 prime numbers
(test print-first-100-prime-numbers
  (finishes
    (terpri)
    (loop  with prime-count = 0
	   for num-index upfrom 2
	   while (not (= prime-count 100))
	   when (prime-p num-index)
	     do
		(princ (format nil "~a~t" num-index))
		(setf prime-count (1+ prime-count)))))
