(in-package :cl-dsa)

(defun move (source destination &key len (src-start 0) (dest-start 0))
  (dotimes (i (or len (length source)))
    (setf (svref destination (+ i dest-start))
	  (svref source (+ i src-start)))))
