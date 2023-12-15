(in-package :cl-aoc)
(export 'cube-conundrum)
;; (export 'split-game-entry)
;; (export 'game-id)
;; (export 'read-color)
;; (export 'read-entry)
;; (export 'read-entries)
;; (export 'make-game-entries)
;; (export 'possible-game-p)
;; (export 'possible-games)
;; (export 'sum-game-ids)


(defun cube-conundrum (color-config game-strings)
  (labels ((sum-game-ids (color-config game-strings)
	     (apply #'+ (possible-games color-config game-strings)))
	   
	   (possible-games (color-config game-strings)
	     (remove-if #'null
			(mapcar #'first
				(remove-if (lambda (g-entry) (not (possible-game-p color-config g-entry)))
					   (mapcar (lambda (game-string) (make-game-entries game-string)) game-strings)
					   :key #'rest))))
	   
	   (possible-game-p (color-config game-color-config)
	     ;; game-color-config is a list of list
	     (and (remove nil game-color-config)
		  (not (remove nil (mapcar (lambda (config game-colors)
					     (and (member config game-colors :test (lambda (color g-color) (> g-color color))) t))
					   color-config game-color-config)))))
	   
	   (make-game-entries (game-entry-string)
	     (let* ((game-value-id "game")
		    (red-color-id "red")
		    (green-color-id "green")
		    (blue-color-id "blue")
		    (game-entries (split-game-entry game-entry-string))
		    (red-color (read-color red-color-id (read-entries red-color-id game-entries)))
		    (green-color (read-color green-color-id (read-entries green-color-id game-entries)))
		    (blue-color (read-color blue-color-id (read-entries blue-color-id game-entries)))
		    (game-value (game-id game-value-id (read-entries game-value-id game-entries))))
	       (cond
		 ((null game-entry-string) nil)
		 ((string= (string-trim " " game-entry-string) "") nil)
		 (t (list game-value red-color green-color blue-color)))))	   
	   
	   (split-game-entry (val)
	     (mapcar (lambda (s)
		       (uiop:split-string (string-trim " " s) :separator '(#\,)))
		     (uiop:split-string val :separator '(#\: #\;))))

	   (read-entries (value-for values &key (test #'string=))
	     (remove value-for values
		     :test-not (lambda (val entry-list)
				 (member val entry-list
					 :test (lambda (val-1 entry)
						 (search (string-downcase val-1) (string-downcase entry) :test test))))))

	   (game-id (game-value-id game-entries)
	     (first (read-entry game-value-id game-entries)))
	   
	   (read-color (color game-entries)
	     (read-entry color game-entries))
	   
	   (read-entry (entry-for entries)
	     (let ((found-entries (mapcar (lambda (entry-list)
					    (first (member entry-for entry-list
							   :test (lambda (val-1 entry)
								   (search (string-downcase val-1) (string-downcase entry))))))
					  entries)))
	       (cond
		 ((null found-entries) (list))
		 (t (mapcar (lambda (found)
			      (parse-integer (coerce (remove-if #'null
								(coerce found 'list)
								:key #'digit-char-p) 'string)))
			    found-entries))))))
    (sum-game-ids color-config game-strings)))
