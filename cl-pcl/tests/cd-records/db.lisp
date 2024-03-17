(in-package #:cl-pcl/tests)

(in-suite* db :in cd-records)

(test clear-records
  (is-true (null (clear-records))))
