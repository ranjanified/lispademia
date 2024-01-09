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
  (finishes (print-primes 100)))

;; Create a function that will return in an array the first “p” prime numbers greater than “n”
(test first-p-primes-greater-than-n
  (is-true (equalp (gen-primes 10 :upfrom 1 :as-array t) #(2 3 5 7 11 13 17 19 23 29)))
  (is-true (equalp (gen-primes 5 :upfrom 40 :as-array t) #(41 43 47 53 59))))

;; Rotate an array to the left 1 position
(test rotate-array-left-1
  (let ((an-array (vector))
	(rotatable-array (vector 1 2 3 4 5)))
    (rotate-left an-array)
    (rotate-left rotatable-array)
    (is-true (equalp an-array (vector)))
    (is-true (equalp rotatable-array (vector 2 3 4 5 1)))))

;; Rotate an array to the right 1 position
(test rotate-array-right-1
  (let ((an-array (vector))
	(rotatable-array (vector 1 2 3 4 5)))
    (rotate-right an-array)
    (rotate-right rotatable-array)
    (is-true (equalp an-array (vector)))
    (is-true (equalp rotatable-array (vector 5 1 2 3 4)))))

;; Reverse an array
(test array-reverse-test
  (let ((an-array (vector))
	(reversible-array (vector 1 2 3 4 5)))
    (array-reverse an-array)
    (array-reverse reversible-array)
    
    (is-true (equalp an-array (vector)))
    (is-true (equalp reversible-array (vector 5 4 3 2 1)))))

;; Reverse a string
(test reverse-string-test
  (is-true (string-equal (reverse-string "") ""))
  (is-true (string-equal (reverse-string "hello") "olleh")))

;; Create a function that will merge two arrays and return the result as a new array
(test merge-arrays-test
  (is-true (equalp (merge-arrays (vector) (vector)) (vector)))
  (is-true (equalp (merge-arrays (vector 1 2 3 4 5) (vector 6 7 8 9)) (vector 1 2 3 4 5 6 7 8 9))))

;; Create a function that will receive two arrays of numbers as arguments and return an array composed of all the numbers that are
;; either in the first array or second array but not in both
(test merge-in-either-or-test
  (is-true (equalp (merge-in-either-or (vector) (vector)) (vector)))
  (is-true (equalp (merge-in-either-or (vector) (vector 1)) (vector 1)))
  (is-true (equalp (merge-in-either-or (vector 1) (vector)) (vector 1)))
  (is-true (equalp (merge-in-either-or (vector 1 2 3 4 5) (vector 2 4 6 4 7)) (vector 1 2 3 4 5 6 7))))

;; Create a function that will receive two arrays and will return an array with elements that are in the first array but not in the second
(test filter-not-in-test
  (is-true (equalp (filter-not-in (vector) (vector)) (vector)))
  (is-true (equalp (filter-not-in (vector) (vector 1 2 3)) (vector)))
  (is-true (equalp (filter-not-in (vector 1 2 3) (vector)) (vector 1 2 3)))
  (is-true (equalp (filter-not-in (vector 1 2 3 4 5 6) (vector 6 7 8 9)) (vector 1 2 3 4 5))))

;; Create a function that will receive an array of numbers as argument and will return a new array with distinct elements
(test make-unique-test
  (is-true (equalp (make-unique (vector)) (vector)))
  (is-true (equalp (make-unique (vector 1)) (vector 1)))
  (is-true (equalp (make-unique (vector 1 1)) (vector 1)))
  (is-true (equalp (make-unique (vector 1 2 1 1 2 3)) (vector 1 2 3))))

;; Calculate the sum of first 100 prime numbers and return them in an array
(test collect-sum-of-primes
  (is-true (equalp (sum-primes 0 :as-array t) (vector)))
  (is-true (equalp (sum-primes 1 :as-array t) (vector 2)))
  (is-true (equalp (sum-primes 2 :as-array t) (vector 2 5)))
  (is-true (equalp (sum-primes 5 :as-array t) (vector 2 5 10 17 28))))

;; Print the distance between the first 100 prime numbers
(test print-distance-between-primes
  (finishes
    (terpri)
    (loop :for distance :across (distance-between-primes 100 :as-array t)
	  :do (princ (format nil "~a~t" distance)))
    (terpri)))

;; Create a function that will add two positive numbers of indefinite size. The numbers are received as strings and the result should be also provided as string.
(test sum-number-strings-test
  (is-true (string= (sum-number-strings "" "") ""))
  (is (string= (sum-number-strings "" "123") "123"))
  (is (string= (sum-number-strings "123" "") "123"))
  (is (string= (sum-number-strings "123" "4567") "4690"))
  (is (string= (sum-number-strings "1234" "445") "1679")))

;; Create a function that will return the number of words in a text
(test count-words-in-text
  (is-true (zerop (count-words "")))
  (is-true (zerop (count-words "    ")))
  (is-true (zerop (count-words "   , , .")))
  (is-true (zerop (count-words ",")))
  (is-true (zerop (count-words ".")))
  (is-true (zerop (count-words "?")))
  (is-true (zerop (count-words "    .")))
  (is-true (zerop (count-words ".    ?")))
  (is-true (= (count-words "hello.") 1))
  (is-true (= (count-words "hello, how do we do?") 5)))

;; Create a function that will capitalize the first letter of each word in a text
(test capitalized-words
  (is-true (string= (capitalize-words "") ""))
  (is-true (string= (capitalize-words "hello") "Hello"))
  (is-true (string= (capitalize-words "hello,     how" :separators (list #\Space)) "Hello, How"))
  (is-true (string= (capitalize-words "hello, How do we do?" :separators (list #\Space)) "Hello, How Do We Do?")))

;; Calculate the sum of numbers received in a comma delimited string
(test sum-csv-numbers-test
  (is-true (zerop (sum-csv-numbers "")))
  (is-true (zerop (sum-csv-numbers "    ")))
  (is-true (zerop (sum-csv-numbers ",")))
  (is-true (zerop (sum-csv-numbers ",     ,")))
  (is-true (zerop (sum-csv-numbers ",,,,,,")))
  (is-true (zerop (sum-csv-numbers ",,    ,,, ,,,   ,,")))
  (is-true (= (sum-csv-numbers "123") 123))
  (is-true (= (sum-csv-numbers ",123") 123))
  (is-true (= (sum-csv-numbers "123,") 123))
  (is-true (= (sum-csv-numbers ",123,  ,,") 123))
  (is-true (= (sum-csv-numbers ",123.6,  ,,") 123.6))
  (is-true (= (sum-csv-numbers ",123,  ,456,") 579))
  (is-true (= (sum-csv-numbers ",123.55,224.45") 348.0)))

;; Create a function that returns an array with words inside a text.
(test split-words-as-array
  (is-true (equalp (split-words "" :as-array t) (vector)))
  (is-true (equalp (split-words "     " :as-array t) (vector)))
  (is-true (equalp (split-words "who tells you   this is a ,  dog" :as-array t) (vector "who" "tells" "you" "this" "is" "a" "dog"))))

;; Create a function to convert a CSV text to a “bi-dimensional” array


;; Create a function that converts a string to an array of characters


;; Create a function that will convert a string in an array containing the ASCII codes of each character


;; Create a function that will convert an array containing ASCII codes in a string


;; Implement the Caesar cypher


;; Implement the bubble sort algorithm for an array of numbers


;; Create a function to calculate the distance between two points defined by their x, y coordinates


;; Create a function that will return a Boolean value indicating if two circles defined by center coordinates and radius are intersecting


;; Create a function that will receive a bi-dimensional array as argument and a number and will extract as a unidimensional array the column specified by the number


;; Create a function that will convert a string containing a binary number into a number


;; Create a function to calculate the sum of all the numbers in a jagged array (contains numbers or other arrays of numbers on an unlimited number of levels)


;; Find the maximum number in a jagged array of numbers or array of numbers


;; Deep copy a jagged array with numbers or other arrays in a new array


;; Create a function to return the longest word in a string


;; Shuffle an array of strings


;; Create a function that will receive n as argument and return an array of n random numbers from 1 to n. The numbers should be unique inside the array.


;; Find the frequency of letters inside a string. Return the result as an array of arrays. Each subarray has 2 elements: letter and number of occurrences.


;; Calculate Fibonacci(500) with high precision (all digits)


;; Calculate 70! with high precision (all digits)

