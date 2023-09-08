(in-package :cl-pcl/tests/suite)

;; (in-suite cd-records)
(def-suite db :in cd-records)
(in-suite db)

(test clear-records
  (is-true (null (clear-records))))
