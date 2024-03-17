(in-package #:cl-pcl/tests)

(in-suite* id3-parser :in cl-pcl-tests)

(defvar id3-tag-instance nil)

(def-fixture id3-object ()
  "ID3 instance creation test"
  (setf id3-tag-instance "aiwehi done")
  (&body)
  (setf id3-tag-instance nil))

(def-test fixtured-test (:fixture id3-object)
  "Testing with a fixture"
  ;; (with-fixture id3-object ()
  ;;   (is (string= id3-tag-instance "aiwehi done")))
  (is (string= id3-tag-instance "aiwehi done")))
