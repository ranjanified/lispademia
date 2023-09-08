(defpackage cl-pcl/tests/suite
  (:use :cl
        :cl-pcl
        :fiveam))

;; NOTE: To run this test file, execute `(asdf:test-system :cl-pcl)' in your Lisp.

(in-package :cl-pcl/tests/suite)

(def-suite cl-pcl)
