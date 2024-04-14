(in-package #:cl-sbcl-ffi)

;;; example call:
;;; (with-alien ((upc_digits (array unsigned-short 11)))
;;;   (setf (deref upc_digits 0) 0)
  
;;;   (setf (deref upc_digits 1) 1)
;;;   (setf (deref upc_digits 2) 3)
;;;   (setf (deref upc_digits 3) 8)
;;;   (setf (deref upc_digits 4) 0)
;;;   (setf (deref upc_digits 5) 0)
  
;;;   (setf (deref upc_digits 6) 1)
;;;   (setf (deref upc_digits 7) 5)
;;;   (setf (deref upc_digits 8) 1)
;;;   (setf (deref upc_digits 9) 7)
;;;   (setf (deref upc_digits 10) 3)
  
;;;   (sbcl-ffi:upc-check-digit upc_digits))
(define-alien-routine "upc_check_digit" unsigned-short (digits (array unsigned-short 11)))

;;; example call:
;;; (with-alien ((reversed-digits (* char) (sbcl-ffi:reverse-digits 1234)))
;;;   (with-alien ((digits-string c-string reversed-digits))
;;;     (format t "Reversed Digits: ~a~%" digits-string))
;;;   (free-alien reversed-digits))
(define-alien-routine "reverse_digits" (* char) (number int))


;;; example call:
;;; (with-alien ((octal-digits (* char) (sbcl-ffi:convert-octal 7)))
;;;   (with-alien ((digits-string c-string octal-digits))
;;;     (format t "Octal Digits: ~a~%" digits-string))
;;;   (free-alien octal-digits))
(define-alien-routine "convert_octal" (* char) (number int))
