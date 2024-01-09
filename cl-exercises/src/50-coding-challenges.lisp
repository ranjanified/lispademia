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
(export 'average-number-array)
(export 'filter-positives)
(export 'max-array)
(export 'print-fibonacci)
(export 'nth-fibonacci)
(export 'prime-p)
(export 'sum-digits)
(export 'print-primes)
(export 'gen-primes)
(export 'rotate-left)
(export 'rotate-right)
(export 'array-reverse)
(export 'reverse-string)
(export 'merge-arrays)
(export 'merge-in-either-or)
(export 'filter-not-in)
(export 'make-unique)
(export 'distance-between-primes)
(export 'sum-primes)
(export 'sum-number-strings)
(export 'split-words)
(export 'count-words)
(export 'capitalize-words)
(export 'sum-csv-numbers)
(export 'string-char-array)

(defun print-numbers (from to)
  (loop
    :for i :from from :to to
    :do (print i)))

(defun print-odd-numbers-between (from to)
  (loop
    :for i :from from :to to
    :when (oddp i)
      :do (print i)))

(defun print-multiplication-table-of (table-of)
  (terpri)
  (loop
    :for times :from 1 :to 10
    :for res := table-of :then (* times table-of)
    :with formatter := "~a~2@t~c~2@t~a~2@t~c~2@t~a"
    :with last-formatter := "~a~2@t~c~2@t~a~@t~c~2@t~a"
    :do (princ (format nil (if (= 10 times) last-formatter formatter) table-of #\x times #\= res))
	(terpri)))

(defun sum-between (from to)
  ;; This can also be solved using a formula for summing an Arithmetic Progression series of numbers
  (loop
    :for num :from from :to to
    :sum num))

(defun calculate-factorial (num)
  (loop
    :for fact-num :from num :downto 1
    :for fact-res := fact-num :then (* fact-num fact-res)
    :finally (return fact-res)))

(defun sum-evens-between (from to &key (exclude-to t))
  (loop for num :from from :to (if exclude-to (1- to) to)
	when (evenp num) sum num))

(defun celsius-fahrenheit (cel)
  (+ (/ (* cel 9.0) 5.0) 32))

(defun fahrenheit-celsius (fah)
  (/ (* 5.0 (- fah 32)) 9.0))

(defun sum-num-array (num-arr)
  (loop
    :for num :across num-arr
    :sum num))

(defun average-number-array (num-array)
  (loop
    :for num :across num-array
    :sum num :into res
    :finally (return (float (/ res (length num-array))))))

(defun filter-positives (num-array)
  (loop
    :for num :across num-array
    :when (>= num 0)
      :collect num :into res
    :finally (return (coerce res '(simple-vector *)))))

(defun max-array (num-array)
  (loop :for num :across num-array
	:maximize num))

(defun print-fibonacci (num-fibs)
  (terpri)
  (loop
    :for count :from 1
    :for fib0 := 0 :then fib1
    :for fib1 := 1 :then curr-fib
    :for curr-fib := fib0 :then (+ fib0 fib1)
    :do (princ (format nil "~a~t" curr-fib))
    :while (> num-fibs count)))

(defun nth-fibonacci (n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (t (+ (nth-fibonacci (1- n)) (nth-fibonacci (- n 2))))))

(defun prime-p (num)
  "https://stackoverflow.com/a/62150343/11697936"
  (cond ((<= num 1) nil)
	((<= num 3) t)
	((or (zerop (rem num 2)) (zerop (rem num 3))) nil)
	(t (loop
	     :with r := t
	     :for i := 5 :then (+ i 6)
	     :while (and r (<= (* i i) num))
	     :do (setf r (not (or (zerop (rem num i)) (zerop (rem num (+ i 2))))))
	     :finally (return r)))))

(defun sum-digits (num &optional (base 10))
  (loop
    :for digit-index := 1 :then (1+ digit-index)
    :for curr-num := num :then (floor (/ curr-num base))
    :for curr-digit := (rem curr-num base)
    :while (not (zerop curr-num))
    :sum curr-digit))

(defun gen-primes (num-primes &key (upfrom 2) (as-array nil))
  (loop
    :with prime-count = 0
    :for num-index :upfrom upfrom
    :until (= prime-count num-primes)
    :when (prime-p num-index)
      :collect num-index :into primes
      :and :do (incf prime-count)
    :finally (return (if as-array
			 (coerce primes `(simple-vector ,num-primes))
			 primes))))

(defun print-primes (num-primes &optional (upfrom 2))
  (terpri)
  (loop
    :for prime :in (gen-primes num-primes :upfrom upfrom)
    :do (princ (format nil "~a~t" prime)))
  (terpri))

(defun rotate-left (an-array &optional (rotation 1))
  (loop
    :repeat rotation
    :do (loop 
	  :for curr-index :from 0 :to (- (length an-array) 2)
	  :do (rotatef (svref an-array curr-index)
		       (svref an-array (1+ curr-index))))))

(defun rotate-right (an-array &optional (rotation 1))
  (loop
    :repeat rotation
    :do (loop 
	  :for curr-index :from (1- (length an-array)) :downto 1
	  :do (rotatef (svref an-array curr-index)
		       (svref an-array (1- curr-index))))))

(defun array-reverse (an-array)
  (loop
    :for start-index :from 0 :and end-index :downfrom (1- (length an-array))
    :until (> start-index end-index)
    :do (rotatef (svref an-array start-index)
		 (svref an-array end-index))))

(defun reverse-string (a-string)
  (let ((string-as-array (coerce a-string 'simple-vector)))
    (array-reverse string-as-array)
    (coerce string-as-array 'string)))

(defun merge-arrays (vector-1 vector-2)
  (loop
    :with a-vec := (make-array (length vector-1) :initial-contents vector-1 :adjustable t :fill-pointer t)
    :for vector-element :across vector-2
    :do (vector-push-extend vector-element a-vec)
    :finally (return a-vec)))

(defun merge-in-either-or (first-vector second-vector)
  (loop
    :for f-ele :across first-vector
    :for second-array := (remove f-ele second-vector) :then (remove f-ele second-array)
    :finally (return (merge-arrays first-vector (or second-array second-vector)))))

(defun filter-not-in (first-vector second-vector)
  (if (zerop (length second-vector))
      first-vector
      (loop
	:for f-ele :across first-vector
	:unless (find f-ele second-vector)
	  :collect f-ele :into res
	:finally (return (coerce res 'simple-vector)))))

(defun make-unique (a-vector)
  (loop
    :for vector-element :across a-vector
    :unless (find vector-element acc)
      :collect vector-element :into acc
    :finally (return (coerce acc 'simple-vector))))

(defun sum-primes (num-primes &key (upfrom 2) (as-array nil))
  (loop :for prime :in (gen-primes num-primes :upfrom upfrom)
	:for sum := prime then (+ prime sum)
	:collect sum :into acc
	:finally (return (if as-array (coerce acc 'simple-vector) acc))))

(defun distance-between-primes (num-primes &key (upfrom 2) (as-array nil))
  (loop :for primes := (gen-primes num-primes :upfrom upfrom) :then (rest primes)
	:until (null (second primes))
	:collect (- (second primes) (first primes)) :into acc
	:finally (return (if as-array (coerce acc 'simple-vector) acc))))

(defun sum-number-strings (f-num-str s-num-str)
  (loop
    :with f-length := (length f-num-str) :and s-length := (length s-num-str)
    :with desired-length := (max f-length s-length)

    :with f-input := (reverse (concatenate 'string (make-string (- desired-length f-length) :initial-element #\0) f-num-str))
    :and s-input := (reverse (concatenate 'string (make-string (- desired-length s-length) :initial-element #\0) s-num-str))

    :for f-digit :across f-input :and s-digit :across s-input
    :and carry := 0 :then (floor (/ (+ (digit-char-p f-digit) (digit-char-p s-digit)) 10))

    :collect (digit-char (rem (+ carry (digit-char-p f-digit) (digit-char-p s-digit)) 10)) :into acc
    :finally (return (coerce (if (zerop (or carry 0)) (reverse acc) (cons carry (reverse acc))) 'string))))

(defun split-words (text-str &key (separators (list #\Space #\Newline #\Tab #\, #\? #\.)) (as-array nil))
  (loop 
    :with in-word := nil :and words := (list) :and curr-word := (list)
    :for curr-char :across text-str
    :when (find curr-char separators)
      :when in-word
	:do (setf in-word nil)
	:and :do (setf words (append words (list (coerce curr-word 'string))))    
	:and :do (setf curr-word (list))
      :end
    :else
      :do (setf in-word t)
      :and :do (setf curr-word (append curr-word (list curr-char)))
    :finally (return (let ((words-list (if curr-word (append words (list (coerce curr-word 'string))) words)))
		       (if as-array
			   (coerce words-list 'simple-vector)
			   words-list)))))

(defun count-words (text-str &key (separators (list #\Space #\Newline #\Tab #\, #\? #\.)))
  (length (split-words text-str :separators separators)))

(defun capitalize-words (text-str &key (separators (list #\Space #\Newline #\Tab #\, #\? #\.)))
  (loop
    :for word :in (split-words text-str :separators separators)
    :collect (string-capitalize word) :into capitalized-words
    :finally (return (string-trim " " (format nil "~{~a~t~}" capitalized-words)))))

(defun sum-csv-numbers (csv-text &key (separators (list #\Space #\Newline #\Tab #\,)))
  (loop
    :for num-str :in (split-words csv-text :separators separators)
    :sum (read-from-string (string-trim " " num-str))))

(defun string-char-array (val-str)
  (loop
    :for chr :across val-str
    :collect chr :into acc
    :finally (return (coerce acc 'simple-vector))))
