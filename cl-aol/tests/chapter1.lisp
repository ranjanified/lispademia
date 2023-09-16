(in-package :cl-aol/tests/main)

(def-suite chapter1 :in cl-aol)
(in-suite chapter1)

(test sexpr-p
  (is-false (sexpr-p (list)))
  (is-true (sexpr-p '(#\A)))
  (is-true (sexpr-p '(#\( #\A #\. #\B #\))))
  (is-true (sexpr-p (coerce "(((A.B).C).(A.B))" 'list)))
  (is-true (sexpr-p (coerce "(A.B)" 'list)))
  (is-true (sexpr-p (coerce "(A.(B.C))" 'list)))
  (is-true (sexpr-p (coerce "((A . B) . C)" 'list)))
  
  (is-false (sexpr-p '(#\A #\. #\B)))
  (is-false (sexpr-p '(#\( #\A #\. #\B #\. #\C #\))))
  (is-false (sexpr-p '(#\( #\( #\A #\. #\B #\) #\)))))

(test digit-p
  (is-true (digit-p #\0))
  (is-true (digit-p #\1))
  (is-true (digit-p #\2))
  (is-true (digit-p #\3))
  (is-true (digit-p #\4))
  (is-true (digit-p #\5))
  (is-true (digit-p #\6))
  (is-true (digit-p #\7))
  (is-true (digit-p #\8))
  (is-true (digit-p #\9))

  (signals SIMPLE-TYPE-ERROR (digit-p 9.5))
  (signals SIMPLE-TYPE-ERROR (digit-p "a")))

(test numeral-p
  (is-true (null (numeral-p (list))))
  (is-true (numeral-p (list #\1)))
  (is-true (numeral-p (list #\1 #\2 #\3)))

  (signals SIMPLE-TYPE-ERROR (numeral-p (list 1.2))))

(test atom-letter-p
  (is-true (atom-letter-p #\a))
  (is-true (atom-letter-p #\b))
  (is-true (atom-letter-p #\Z))

  (signals TYPE-ERROR (atom-letter-p 7)))

(test literal-atom-p
  (is-true (null (literal-atom-p (list))))
  (is-true (literal-atom-p (list #\h #\e #\l #\l #\o)))
  (is-true (literal-atom-p (list #\h #\1 #\e #\2 #\l #\l #\o)))

  ;; First one isn't an atom-letter
  (is-false (literal-atom-p (list #\4 #\h #\1 #\e #\2 #\l #\l #\o)))

  (signals TYPE-ERROR (literal-atom-p '(7))))

(test atom-p
  (is-true (atom-p '()))
  (is-true (atom-p (list #\A #\B #\C #\1 #\2 #\3)))
  (is-true (atom-p (list #\1 #\2)))
  (is-true (atom-p (list #\A #\4 #\D #\6)))
  (is-true (atom-p (list #\N #\I #\L)))
  (is-true (atom-p (list #\T)))

  (is-false (atom-p (list #\2 #\A)))
  (is-false (atom-p (list #\$ #\$ #\g)))
  (is-false (atom-p (list #\A #\B #\D #\.)))
  (is-false (atom-p (list #\( #\A #\. #\B #\)))))

;; (test sexpr-p
;;   (is-true (null (sexpr-p '())))
;;   (is-true (sexpr-p (list #\A)))
;;   (is-true (sexpr-p (list (list #\A #\B)))))
