(defun splice (lst &key (start 0) (end (length lst)) new)
  (setf lst (cons nil lst))
  (let ((reroute-start (nthcdr start lst)))
    (setf (cdr reroute-start)
	  (nconc (make-list (length new))
		 (nthcdr (- end start)
			 (cdr reroute-start)))
	  lst (cdr lst))
    (replace lst new :start1 start)
    lst))

(defun fermat (n)
  (1+ (expt 2 (expt 2 n))))

(defconstant +mod+ (expt 2 32))

(defun plus-mod (x y) (mod (+ x y) +mod+))

(defun plus-rem (x y) (rem (* x y) +mod+))
