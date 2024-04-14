(in-package #:cl-sbcl-ffi)

;;; example call:
;;; (with-alien ((prints (* char) (sbcl-ffi:tprintf 40 839.210)))
;;;   (with-alien ((print-str c-string prints)) 
;;;     (format t "~a~%" print-str))
;;;   (free-alien prints))
(define-alien-routine "tprintf" (* char) (i int) (j float))

;;; example call:
;;; (with-alien ((fraction-sum (* char) (sbcl-ffi:add-fraction 40 50 839 210)))
;;;   (with-alien ((print-str c-string fraction-sum)) 
;;;     (format t "~a~%" print-str))
;;;   (free-alien fraction-sum))
(define-alien-routine "add_fraction" (* char) (n1 int) (d1 int) (n2 int) (d2 int))
