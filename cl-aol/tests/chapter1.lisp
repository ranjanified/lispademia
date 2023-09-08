(in-package :cl-aol/tests/main)

(def-suite chapter1 :in cl-aol)
(in-suite chapter1)

(test is-digit
  (is-true (is-digit #\0))
  (is-true (is-digit #\1))
  (is-true (is-digit #\2))
  (is-true (is-digit #\3))
  (is-true (is-digit #\4))
  (is-true (is-digit #\5))
  (is-true (is-digit #\6))
  (is-true (is-digit #\7))
  (is-true (is-digit #\8))
  (is-true (is-digit #\9))

  (signals SIMPLE-TYPE-ERROR (is-digit 9.5))
  (signals SIMPLE-TYPE-ERROR (is-digit "a")))

(test is-numeral
  (is-true (null (is-numeral (list))))
  (is-true (is-numeral (list #\1)))
  (is-true (is-numeral (list #\1 #\2 #\3)))

  (signals SIMPLE-TYPE-ERROR (is-numeral (list 1.2))))

(test is-letter
  (is-true (is-letter #\a))
  (is-true (is-letter #\b))
  (is-true (is-letter #\Z))

  (signals TYPE-ERROR (is-letter 7)))

(test is-literal
  (is-true (null (is-literal (list))))
  (is-true (is-literal (list #\h #\e #\l #\l #\o)))
  (is-true (is-literal (list #\h #\1 #\e #\2 #\l #\l #\o)))

  (signals TYPE-ERROR (is-literal '(7))))
