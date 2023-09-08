(in-package :cl-pcl)

(defvar *db* (list))

(defun add-record (cd-rec)
  (push cd-rec *db*))

(defun clear-records ()
  (setf *db* (list)))
