(defun count-blanks (value-str cnt)
  (cond
    ((null value-str) cnt)
    ((member (first value-str) (list #\Space #\Tab)) (count-blanks (rest value-str) (1+ cnt)))
    (t (count-blanks (rest value-str) cnt))))

(defun word-count (chr-lst)
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
