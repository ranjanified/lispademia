(in-package #:cl-sbcl-ffi)

(define-alien-routine "broker_commision" single-float (trade_amount single-float))

;;; example call:
;;; (with-alien ((worded-number (* char) (cl-sbcl-ffi:worded-number 22)))
;;;   (with-alien ((number-string c-string worded-number))
;;;     (format t "Number as Word: ~a~%" number-string))
;;;   (free-alien worded-number))
;;; or when error,
;;; (with-alien ((worded-number (* char) (cl-sbcl-ffi:worded-number 1)))
;;;   (with-alien ((number-string c-string worded-number))
;;;     (format t "Number as Word: ~a, ~a~%" number-string (get-errno)))
;;;   (free-alien worded-number))
(define-alien-routine "worded_number" (* char) (two-digit-number unsigned-short))

;;; example call
;;; (cl-sbcl-ffi:count-digits 999)
(define-alien-routine "count_digits" unsigned-short (number unsigned-long))
