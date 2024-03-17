(defpackage #:cl-pcl/tests
  (:use #:cl
        #:cl-pcl
        #:fiveam)
  (:export #:run-tests))

(in-package #:cl-pcl/tests)
(def-suite cl-pcl-tests)

(defgeneric warmup-test-suite (suite))

(defun run-warmups ()
  (warmup-test-suite 'id3-parser))

(defun run-tests ()
  (run-warmups)
  (run! 'cl-pcl-tests))
