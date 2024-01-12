;;;; https://codeguppy.com/site/download/50_coding_challenges.pdf

(in-package :cl-exercises/tests)

;; (def-suite print-numbers-tests :in cl-exercises-tests)
(in-suite* :cl-exercises-tests)

;; 1. Print Numbers from 1 to 10
(test print-numbers-1-10
      (finishes (print-numbers 1 10)))

;; 2. Print the odd numbers less than 100
(test print-odd-numbers-less-than-100
  (finishes (print-odd-numbers-between 0 100)))

;; 3. Print the multiplication table with 7
(test print-multiplication-table-of-7
  (finishes (print-multiplication-table-of 7)))

;; 4. Print all the multiplication tables with numbers from 1 to 10
(test print-all-multiplication-tables-from-1-to-10
    (finishes (loop for i :from 1 :to 10
		    do (print-multiplication-table-of i))))

;; 5. Calculate the sum of numbers from 1 to 10
(test sum-numbers-between-1-to-100
  (is (= 5050 (sum-between 1 100))))

;; 6. Calculate 10!
(test calculate-factorial-of-10
  (is (= 3628800 (calculate-factorial 10))))

;; 7. Calculate the sum of even numbers greater than 10 and less than 30
(test sum-evens-between-10-and-30
  (is (= 190 (sum-evens-between 10 30))))

;; 8. Create a function that will convert from Celsius to Fahrenheit
(test celsius-to-fahrenheit
  (is (= 99.5 (celsius-fahrenheit 37.5))))

;; 9. Create a function that will convert from Fahrenheit to Celsius
(test fahrenheit-to-celsius
  (is (= 37.5 (fahrenheit-celsius 99.5))))

;; 10. Calculate the sum of numbers in an array of numbers
(test sum-number-array
  (is (= 15 (sum-num-array #(1 2 3 4 5)))))

;; 11. Calculate the average of the numbers in an array of numbers
(test average-number-array-test
      (is (= 5.5 (average-number-array #(1 2 3 4 5 6 7 8 9 10)))))

;; 12. Create a function that receives an array of numbers as argument and returns an array containing only the positive numbers
(test filter-positives-from-array
  (is-true (let* ((num-array #(2 -3 4 -9 -7 6))
		  (positives (filter-positives num-array)))
	     (and (arrayp positives) (equalp positives #(2 4 6))))))

;; 13. Find the maximum number in an array of numbers
(test max-in-array
  (is (= 90 (max-array #(1 13 65 88 6 7 90 65)))))

;; 14. Print the first 10 Fibonacci numbers without recursion
(test print-fibonacci-first-10
  (finishes (print-fibonacci 10)))

;; 15. Create a function that will find the nth Fibonacci number using recursion
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

;; 16. Create a function that will return a Boolean specifying if a number is prime
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

;; 17. Calculate the sum of digits of a positive integer number
(test sum-of-digits-of-a-number
  (is-true (zerop (sum-digits 0)))
  (is (= 8 (sum-digits 8)))
  (is (= 16 (sum-digits 772)))
  (is (= 26 (sum-digits 998)))
  (is (= 10 (sum-digits 102034))))

;; 18. Print the first 100 prime numbers
(test print-first-100-prime-numbers
  (finishes (print-primes 100)))

;; 19. Create a function that will return in an array the first “p” prime numbers greater than “n”
(test first-p-primes-greater-than-n
  (is-true (equalp (gen-primes 10 :upfrom 1 :as-array t) #(2 3 5 7 11 13 17 19 23 29)))
  (is-true (equalp (gen-primes 5 :upfrom 40 :as-array t) #(41 43 47 53 59))))

;; 20. Rotate an array to the left 1 position
(test rotate-array-left-1
  (let ((an-array (vector))
	(rotatable-array (vector 1 2 3 4 5)))
    (rotate-left an-array)
    (rotate-left rotatable-array)
    (is-true (equalp an-array (vector)))
    (is-true (equalp rotatable-array (vector 2 3 4 5 1)))))

;; 21. Rotate an array to the right 1 position
(test rotate-array-right-1
  (let ((an-array (vector))
	(rotatable-array (vector 1 2 3 4 5)))
    (rotate-right an-array)
    (rotate-right rotatable-array)
    (is-true (equalp an-array (vector)))
    (is-true (equalp rotatable-array (vector 5 1 2 3 4)))))

;; 22. Reverse an array
(test array-reverse-test
  (let ((an-array (vector))
	(reversible-array (vector 1 2 3 4 5)))
    (array-reverse an-array)
    (array-reverse reversible-array)
    
    (is-true (equalp an-array (vector)))
    (is-true (equalp reversible-array (vector 5 4 3 2 1)))))

;; 23. Reverse a string
(test reverse-string-test
  (is-true (string-equal (reverse-string "") ""))
  (is-true (string-equal (reverse-string "hello") "olleh")))

;; 24. Create a function that will merge two arrays and return the result as a new array
(test merge-arrays-test
  (is-true (equalp (merge-arrays (vector) (vector)) (vector)))
  (is-true (equalp (merge-arrays (vector 1 2 3 4 5) (vector 6 7 8 9)) (vector 1 2 3 4 5 6 7 8 9))))

;; 25. Create a function that will receive two arrays of numbers as arguments and return an array composed of all the numbers that are
;; either in the first array or second array but not in both
(test merge-in-either-or-test
  (is-true (equalp (merge-in-either-or (vector) (vector)) (vector)))
  (is-true (equalp (merge-in-either-or (vector) (vector 1)) (vector 1)))
  (is-true (equalp (merge-in-either-or (vector 1) (vector)) (vector 1)))
  (is-true (equalp (merge-in-either-or (vector 1 2 3 4 5) (vector 2 4 6 4 7)) (vector 1 2 3 4 5 6 7))))

;; 26. Create a function that will receive two arrays and will return an array with elements that are in the first array but not in the second
(test filter-not-in-test
  (is-true (equalp (filter-not-in (vector) (vector)) (vector)))
  (is-true (equalp (filter-not-in (vector) (vector 1 2 3)) (vector)))
  (is-true (equalp (filter-not-in (vector 1 2 3) (vector)) (vector 1 2 3)))
  (is-true (equalp (filter-not-in (vector 1 2 3 4 5 6) (vector 6 7 8 9)) (vector 1 2 3 4 5))))

;; 27. Create a function that will receive an array of numbers as argument and will return a new array with distinct elements
(test make-unique-test
  (is-true (equalp (make-unique (vector)) (vector)))
  (is-true (equalp (make-unique (vector 1)) (vector 1)))
  (is-true (equalp (make-unique (vector 1 1)) (vector 1)))
  (is-true (equalp (make-unique (vector 1 2 1 1 2 3)) (vector 1 2 3))))

;; 28. Calculate the sum of first 100 prime numbers and return them in an array
(test collect-sum-of-primes
  (is-true (equalp (sum-primes 0 :as-array t) (vector)))
  (is-true (equalp (sum-primes 1 :as-array t) (vector 2)))
  (is-true (equalp (sum-primes 2 :as-array t) (vector 2 5)))
  (is-true (equalp (sum-primes 5 :as-array t) (vector 2 5 10 17 28))))

;; 29. Print the distance between the first 100 prime numbers
(test print-distance-between-primes
  (finishes
    (terpri)
    (loop :for distance :across (distance-between-primes 100 :as-array t)
	  :do (princ (format nil "~a~t" distance)))
    (terpri)))

;; 30. Create a function that will add two positive numbers of indefinite size. The numbers are received as strings and the result should be also provided as string.
(test sum-number-strings-test
  (is-true (string= (sum-number-strings "" "") ""))
  (is (string= (sum-number-strings "" "123") "123"))
  (is (string= (sum-number-strings "123" "") "123"))
  (is (string= (sum-number-strings "123" "4567") "4690"))
  (is (string= (sum-number-strings "1234" "445") "1679")))

;; 31. Create a function that will return the number of words in a text
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

;; 32. Create a function that will capitalize the first letter of each word in a text
(test capitalized-words
  (is-true (string= (capitalize-words "") ""))
  (is-true (string= (capitalize-words "hello") "Hello"))
  (is-true (string= (capitalize-words "hello,     how" :separators (list #\Space)) "Hello, How"))
  (is-true (string= (capitalize-words "hello, How do we do?" :separators (list #\Space)) "Hello, How Do We Do?")))

;; 33. Calculate the sum of numbers received in a comma delimited string
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

;; 34. Create a function that returns an array with words inside a text.
(test split-words-as-array
  (is-true (equalp (split-words "" :as-array t) (vector)))
  (is-true (equalp (split-words "     " :as-array t) (vector)))
  (is-true (equalp (split-words "who tells you   this is a ,  dog" :as-array t) (vector "who" "tells" "you" "this" "is" "a" "dog"))))

;; 35. Create a function to convert a CSV text to a “bi-dimensional” array


;; 36. Create a function that converts a string to an array of characters
(test string-to-char-array
  (is-true (equalp (string-char-array "") (vector)))
  (is-true (equalp (string-char-array " ") (vector #\Space)))
  (is-true (equalp (string-char-array "Nalin") (vector #\N #\a #\l #\i #\n)))
  (is-true (equalp (string-char-array "Nalin Ranjan") (vector #\N #\a #\l #\i #\n #\Space #\R #\a #\n #\j #\a #\n))))

;; 37. Create a function that will convert a string in an array containing the ASCII codes of each character
(test string-to-char-codes-array
  (is-true (equalp (string-char-codes "") (vector)))
  (is-true (equalp (string-char-codes " ") (vector 32)))
  (is-true (equalp (string-char-codes "Nalin") (vector 78 97 108 105 110)))
  (is-true (equalp (string-char-codes "Nalin Ranjan") (vector 78 97 108 105 110 32 82 97 110 106 97 110))))

;; 38. Create a function that will convert an array containing ASCII codes in a string
(test char-codes-string-test
  (is-true (string= (char-codes-string (vector)) ""))
  (is-true (string= (char-codes-string (vector 32)) " "))
  (is-true (string= (char-codes-string (vector 78 97 108 105 110)) "Nalin"))
  (is-true (string= (char-codes-string (vector 78 97 108 105 110 32 82 97 110 106 97 110)) "Nalin Ranjan")))

;; 39. Implement the Caesar cypher
(test caeser-ciphers
  (is-true (and (equalp (caeser-cipher "" 25) (vector))
		(string= (caeser-plain (vector) 25) "")))
  (is-true
   (let ((key 25)
	 (plain-text "hello")
	 (cipher-text (vector 129 126 133 133 136)))
     (and
      (equalp (caeser-cipher plain-text key) cipher-text)
      (string= (caeser-plain cipher-text key) plain-text)))))

;; 40. Implement the bubble sort algorithm for an array of numbers
(test bubble-sort-tests
  (is-true (let ((an-array (vector)))
	     (bubble-sort an-array)
	     (equalp an-array (vector))))
  (is-true (let ((an-array (vector 1)))
	     (bubble-sort an-array)
	     (equalp an-array (vector 1))))
  (is-true (let ((an-array (vector 10 10 10 10)))
	     (bubble-sort an-array)
	     (equalp an-array (vector 10 10 10 10))))
  (is-true (let ((an-array (vector 25 57 48 37 12 92 86 33)))
		 (bubble-sort an-array)
		 (equalp an-array (vector 12 25 33 37 48 57 86 92)))))

;; 41. Create a function to calculate the distance between two points defined by their x, y coordinates
(test distance-between-two-points-test
  (is-true (zerop (distance-between-points 0 0 0 0)))
  (is-true (= (distance-between-points 0 0 5 5) 7.071068)))

;; 42. Create a function that will return a Boolean value indicating if two circles defined by center coordinates and radius are intersecting
(test circles-intersect
  (is-false (circles-intersect-p))
  (is-false (circles-intersect-p :circle-1 (vector 0 0 5)))
  (is-false (circles-intersect-p :circle-2 (vector 0 0 5)))
  (is-false (circles-intersect-p :circle-1 (vector 0 0 5) :circle-2 (vector 0 0 3)))
  (is-true (circles-intersect-p :circle-1 (vector 2 3 22) :circle-2 (vector 15 28 10))))

;; 43. Create a function that will receive a bi-dimensional array as argument and a number and will extract as a unidimensional array the column specified by the number
(test access-array-column
  ;; (is-true (equalp (array-column (make-array nil)) (vector)))
  (is-true (equalp (array-column (make-array (list 1 1))) (vector 0)))
  (is-true (equalp (array-column (make-array (list 1 1) :initial-contents '((4)))) (vector 4)))
  (is-true (equalp (array-column (make-array (list 5 2) :initial-contents '((1 2) (3 4) (5 6) (7 8) (9 10)))) (vector 1 3 5 7 9)))
  (is-true (equalp (array-column (make-array (list 5 2) :initial-contents '((1 2) (3 4) (5 6) (7 8) (9 10))) 1) (vector 2 4 6 8 10))))

;; 44. Create a function that will convert a string containing a binary number into a number
(test sum-bit-string-test
  (is-true (zerop (sum-bit-string "")))
  (is-true (= (sum-bit-string "1") 1))
  (is-true (= (sum-bit-string "10") 2))
  (is-true (= (sum-bit-string "1011") 11)))

;; 45. Create a function to calculate the sum of all the numbers in a jagged array (contains numbers or other arrays of numbers on an unlimited number of levels)
(test sum-jagged-arrays
  (is-true (zerop (sum-jagged (vector))))
  (is-true (zerop (sum-jagged (vector (vector) (vector)))))
  (is-true (= (sum-jagged (vector 1)) 1))
  (is-true (= (sum-jagged (vector (vector 1))) 1))
  (is-true (= (sum-jagged (vector 1 2 (vector 3) 4)) 10)))

;; 46. Find the maximum number in a jagged array of numbers or array of numbers
(test max-jagged-number
  (is-true (zerop (jagged-max (vector))))
  (is-true (zerop (jagged-max (vector (vector)))))
  (is-true (zerop (jagged-max (vector 0))))
  (is-true (= (jagged-max (vector 0 (vector 1))) 1))
  (is-true (= (jagged-max (vector 0 (vector 1) 7 5 (vector 17 18 44))) 44)))

;; 47. Deep copy a jagged array with numbers or other arrays in a new array
(test deep-copy-jagged-array
  (is-true (let ((an-array (vector)))
	     (and (not (eq an-array (jagged-deep-copy an-array)))
		  (equalp (jagged-deep-copy an-array) (vector)))))
  (is-true (let ((an-array (vector 1 2 (vector 3 4 (vector 5 6 7) (vector 8) (vector 9 10)))))
	     (and (not (eq an-array (jagged-deep-copy an-array)))
		  (equalp (jagged-deep-copy an-array) (vector 1 2 (vector 3 4 (vector 5 6 7) (vector 8) (vector 9 10))))))))

;; 48. Create a function to return the longest word in a string
(test longest-word-in-a-string
  (is-true (string= (longest-word "") ""))
  (is-true (string= (longest-word "  ") ""))
  (is-true (string= (longest-word "  hi, ") "hi"))
  (is-true (string= (longest-word "Hey, are we doing a hello to Mr Nalin") "Nalin")))

;; 49. Shuffle an array of strings
(test shuffle-strings-test
  (finishes (let ((strings (vector)))
	      (shuffle-strings strings)
	      (equalp strings (vector))))
  (finishes (let ((strings (vector "who" "is" "going" "berserk")))
	      (shuffle-strings strings)
	      (print strings)))
  (finishes (let ((strings (vector "To" "shuffle" "an" "array" "a" "of" "n" "elements" "(indices 0..n-1)" ":")))
	      (shuffle-strings strings)
	      (print strings))))

;; 50. Create a function that will receive n as argument and return an array of n random numbers from 1 to n. The numbers should be unique inside the array.
(test n-random-tests
  (is-true (let ((randoms (n-randoms 0))) (equalp randoms (vector))))
  (is-true (let ((randoms (n-randoms 1))) (equalp randoms (vector 1))))
  (is-true (let ((randoms (n-randoms 5))) (and (= (length randoms) 5) (= (length (make-unique randoms)) 5)))))

;; 51. Find the frequency of letters inside a string. Return the result as an array of arrays. Each subarray has 2 elements: letter and number of occurrences.
(test letter-frequencies-test
  (is-true (equalp (letter-frequencies "") (vector)))
  (is-true (equalp (letter-frequencies "  ") (vector)))
  (is-true (equalp (letter-frequencies "     h hh   h   ") (vector (vector #\h 4))))
  (is-true (equalp (letter-frequencies "how           to      ?") (vector (vector #\h 1) (vector #\o 2) (vector #\w 1) (vector #\t 1))))
  (is-true (equalp (letter-frequencies "this is big --!") (vector (vector #\t 1) (vector #\h 1) (vector #\i 3) (vector #\s 2) (vector #\b 1) (vector #\g 1)))))

;; 52. Calculate Fibonacci(500) with high precision (all digits)
(test fibonacci-500
  (finishes (print (fib-n 500))))

;; 53. Calculate 70! with high precision (all digits)
(test factorial
  (is-true (zerop (fact 0)))
  (is-true (= (fact 1) 1)))

(test factorial-70
  (finishes (print (fact 70))))
