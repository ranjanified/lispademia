(defun strlen (strings)
  (declare (type (simple-array character *) strings))
  (do (i 0 (1+ i))
      ((char/= (elt strings i) #\Nul) i)))

(defun strpos (string1 string2)
  (declare (type (simple-array character *) string1 string2))
  )
