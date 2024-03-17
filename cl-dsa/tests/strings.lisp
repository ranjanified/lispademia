(in-package #:cl-dsa/tests)

(in-suite* strings :in cl-dsa-tests)

(test strlen
  (is-true (zerop (strlen "")))
  (is-true (zerop (strlen (make-array '(0)))))
  (is-true (= 1 (strlen (make-array '(2) :initial-contents '(#\a #\Nul)))))
  (is-true (= 5 (strlen (make-array '(6) :initial-contents '(#\n #\a #\l #\i #\n #\Nul))))))

(test strpos
  (let ((string1 (make-array '(0)))
	(string2 (make-array '(0))))
    (is-true (= -1 (strpos string1 string2))))
  (let ((string1 (make-array '(1) :initial-contents '(#\Nul)))
	(string2 (make-array '(1) :initial-contents '(#\Nul))))
    (is-true (= -1 (strpos string1 string2))))
  (let ((string1 (make-array '(6) :initial-contents '(#\h #\e #\l #\l #\o #\Nul)))
	(string2 (make-array '(1) :initial-contents '(#\Nul))))
    (is-true (= -1 (strpos string1 string2))))
  (let ((string1 (make-array '(1) :initial-contents '(#\Nul)))
	(string2 (make-array '(6) :initial-contents '(#\h #\e #\l #\l #\o #\Nul))))
    (is-true (= -1 (strpos string1 string2))))
  (let ((string1 (make-array '(6) :initial-contents '(#\h #\e #\l #\l #\o #\Nul)))
	(string2 (make-array '(4) :initial-contents '(#\l #\l #\o #\Nul))))
    (is-true (= 2 (strpos string1 string2)))))
