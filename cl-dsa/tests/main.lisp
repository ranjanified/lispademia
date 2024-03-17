(defpackage #:cl-dsa/tests
  (:use #:cl
        #:cl-dsa
        #:fiveam))

(in-package #:cl-dsa/tests)

(def-suite cl-dsa-tests)

(defgeneric warmup-suite (suite))

(defun run-warmups ())

(defun run-tests ()
  (run-warmups)
  (run! 'cl-dsa-tests))
