(in-package #:cl-dsa)

(defun count-blanks (value-str)
  (labels ((cnt-blanks (val cnt)
	     (cond
	       ((null val) cnt)
	       ((member (first val) (list #\Space #\Tab)) (cnt-blanks (rest val) (1+ cnt)))
	       (t (cnt-blanks (rest val) cnt)))))
    (cnt-blanks (coerce value-str 'list) 0)))

(defun word-count ()
  (loop 
    with curr-char = nil and in-word = 1 and out-word = 0 
    and line-count = 0 and word-count = 0 and char-count = 0
    and curr-state = 0 ;; it should have been a reference to out-word  
    
    if (eq curr-char 'eof) return (list "char count:" char-count "word count:" word-count "Line Count:" line-count) 
      else do (setq curr-char (read-char nil nil 'eof))
	      (if (eq 'eof curr-char)
		  (incf line-count)
		  (progn
		    (incf char-count)
		    (when (char= curr-char #\Newline) (incf line-count))
		    (cond ((or (char= curr-char #\Space)
			       (char= curr-char #\Newline)
			       (char= curr-char #\Tab))
			   (setq curr-state out-word))
			  (t (when (= curr-state out-word)
			       (setq curr-state in-word)
			       (incf word-count))))))))
