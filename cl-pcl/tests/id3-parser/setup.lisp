(in-package #:cl-pcl/tests)

(in-suite* id3-parser :in cl-pcl-tests)

(defmethod warmup-test-suite ((suite (eql 'id3-parser)))
  (format t "warming up test suite id3-parser"))
