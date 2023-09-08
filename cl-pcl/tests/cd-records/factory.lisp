(in-package :cl-pcl/tests/suite)

(def-suite factory :in cd-records)
(in-suite factory)

(test make-cd
  (let ((cd (make-cd nil nil nil nil))
	(cd2 (make-cd "cd-1" "nalin" 3 t)))
    (is-true (null (getf cd :title)))
    (is-true (null (getf cd :artist)))
    (is-true (null (getf cd :rating)))
    (is-true (null (getf cd :ripped)))

    (is-true (string= (getf cd2 :title) "cd-1"))
    (is-true (string= (getf cd2 :artist) "nalin"))
    (is-true (= (getf cd2 :rating) 3))
    (is-true (getf cd2 :ripped))))
