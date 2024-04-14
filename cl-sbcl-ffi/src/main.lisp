(defpackage #:cl-sbcl-ffi
  (:use #:cl #:sb-alien #:sb-c-call)
  (:export ; modern-c
   ;; chapter 2
   #:print-pun
   #:dimensional-weight-of-box
   #:fahrenheit-to-celsius
   #:sphere-volume
   #:taxed-dollars
   #:solve-polynomial-for
   #:opt-solve-polynomial-for
   #:dollar-bills
   #:loan-repayment

   ;; chapter 3
   #:tprintf
   #:add-fraction

   ;; chapter 4
   #:upc-check-digit
   #:reverse-digits
   #:convert-octal
   ))