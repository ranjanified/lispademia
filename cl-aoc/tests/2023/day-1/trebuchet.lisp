(in-package :cl-aoc/tests/main)

(def-suite aoc-2023 :in cl-aoc)
(in-suite aoc-2023)

(test trebuchet
  (let ((calibration-document-1 '("abc" "pqrstuvwx" "abcdef" "trebuchet"))
	(calibration-document-2 '("1abc2" "pqr3stu8vwx" "a1b2c3d4e5f" "treb7uchet")))
    (is-true (= 0 (trebuchet '())))
    (is-true (= 0 (trebuchet calibration-document-1)))
    (is-true (= 142 (trebuchet calibration-document-2)))
    (is (= 54239 (trebuchet (uiop:read-file-lines
			     (merge-pathnames (asdf:system-relative-pathname "cl-aoc" "tests/2023/day-1/")
					      #P"input.txt")))))))
