(defpackage #:cl-3ed
  (:use #:cl)
  (:shadow #:first #:rest #:evenp #:union)
  (:export #:first #:rest #:insert #:union)
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
  (:export #:mystery)
  (:export #:strange)
  (:export #:squash)
  (:export #:fibonacci)
  (:export #:union))
