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

   ;; chapter 5
   #:broker-commision
   #:worded-number
   #:count-digits
   #:format-time-12
   #:min-max-quad)

  (:export ; c-algorithms
   ;; chapter 2
   #:euclid-gcd
   #:reduce-fraction #:fraction
   #:convert-int
   #:binary
   #:gcd-triplet
   #:largest-pair-with-gcd-1

   ;; chapter 3
   #:sieve-primes
   #:singly-linkedlist-node
   #:key #:singly-ll-keys
   #:next #:singly-ll-nexts
   #:singly-ll-head #:singly-ll-tail #:singly-ll-current
   #:list-initialize #:singly-ll-initialize
   #:delete-next #:singly-ll-delete-next
   #:insert-after #:singly-ll-insert-after
   #:head #:tail #:stack-struct
   #:stack-initialize #:stack-uninitialize #:stack-push #:stack-pop #:stack-empty
   #:stack-contents

   #:infix-postfix

   #:queue-initialize #:queue-insert #:queue-remove #:queue-empty
   #:queue-struct

   #:fill-having-gcd-1 #:free-fill-array-having-gcd-1
   #:move-next-to-front

   #:stdout-format #:stdout-formatter
   ))

(in-package #:cl-sbcl-ffi)

(define-alien-variable stdout-format (* (function void c-string)))

(define-alien-callable stdout-formatter void ((fmt-str c-string))
  (format t "~&~a~%" fmt-str))



