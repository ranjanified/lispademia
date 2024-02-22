(defpackage #:cl-3ed
  (:use #:cl)
  (:shadow #:first #:rest #:evenp)
  (:export #:first #:rest #:insert)
  (:export #:rotate-l #:rotate-r)
  (:export #:palindromize)
  (:export #:f-to-c #:c-to-f)
  (:export #:roots)
  (:export #:evenp)
  (:export #:palindrome-p)
  (:export #:right-p)
  (:export #:complex-p)
  (:export #:nilcar #:nilcdr)
  (:export #:check-temperature)
  (:export #:circle)

  ;; chapter 4
  (:export #:mystery))
