(in-package #:cl-ebnf)

(define-condition malformed-token (serious-condition)
  ((token-type :reader malformed-token-type
	       :initarg :token-type))
  (:report (lambda (condition stream)
	     (format stream "Malfomed Token: ~a~&" (malformed-token-type condition)))))
