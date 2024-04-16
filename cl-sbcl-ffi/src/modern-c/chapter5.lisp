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

;;; example call:
;;; (with-alien ((12-hour-time (* char) (cl-sbcl-ffi:format-time-12 22 30)))
;;;   (with-alien ((time-string c-string 12-hour-time))
;;;     (format t "Equivalent 12-hour time: ~a~%" time-string))
;;;   (free-alien 12-hour-time))
(define-alien-routine "format_time_12" (* char) (hour unsigned-short) (minutes unsigned-short))

;;; example call:
;;; (with-alien ((min-max (* int) (cl-sbcl-ffi:min-max-quad 7 12 9 8)))
;;;   (format t "max: ~a, min: ~a~%" (deref min-max 0) (deref min-max 1))
;;;   (free-alien min-max))
(define-alien-routine "min_max_quad" (* int) (a int) (b int) (c int) (d int))
