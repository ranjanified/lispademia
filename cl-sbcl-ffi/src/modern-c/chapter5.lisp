(in-package #:cl-sbcl-ffi)

(define-alien-routine "broker_commision" single-float (trade_amount single-float))
