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
