(in-package #:cl-ebnf)

(defun letter-p (chr)
  (or (and (char>= chr #\a)(char<= chr #\z))
      (and (char>= chr #\A)(char<= chr #\Z))))

(defun decimal-digit-p (chr)
  (and (digit-char-p chr) t))

(defun concatenate-symbol-p (chr)
  (char= #\, chr))

(defun defining-symbol-p (chr)
  (char= #\= chr))

(defun definition-separator-symbol-p (chr)
  (or (char= #\| chr)
      ;; alternate representation
      (char= #\/ chr)
      (char= #\! chr)))

(defun start-comment-symbol-p (chr-start chr-end)
  (and (char= #\( chr-start) (char= #\* chr-end)))

(defun end-comment-symbol-p (chr-start chr-end)
  (and (char= #\* chr-start) (char= #\) chr-end)))

(defun start-group-symbol-p (chr)
  (char= #\( chr))

(defun end-group-symbol-p (chr)
  (char= #\) chr))

(defun start-option-symbol-p (chr-start &optional chr-end)
  (or (and (char= #\[ chr-start) (null chr-end))
      ;; alternate representation
      (and (char= #\( chr-start) (char= #\/ chr-end))))

(defun end-option-symbol-p (chr-start &optional chr-end)
  (or (and (char= #\] chr-start) (null chr-end))
      ;; alternate representation
      (and (char= #\/ chr-start) (char= #\) chr-end))))

(defun start-repeat-symbol-p (chr-start &optional chr-end)
  (or (and (char= #\{ chr-start) (null chr-end))
      ;; alternate representation
      (and (char= #\( chr-start) (char= #\:))))

(defun end-repeat-symbol-p (chr-start &optional chr-end)
  (or (and (char= #\} chr-start) (null chr-end))
      ;; alternate representation
      (and (char= #\: chr-end) (char= #\) chr-end))))

(defun terminator-symbol-p (chr)
  (or (char= #\; chr)
      ;; alternate representation
      (char= #\. chr)))

(defun other-character-p (chr)
  (or (char= #\Space chr)
      (char= #\. chr)
      (char= #\: chr)
      (char= #\! chr)
      (char= #\+ chr)
      (char= #\_ chr)
      (char= #\% chr)
      (char= #\@ chr)
      (char= #\& chr)
      (char= #\# chr)
      (char= #\$ chr)
      (char= #\< chr)
      (char= #\> chr)
      (char= #\/ chr)
      (char= #\\ chr)
      (char= #\^ chr)
      (char= #\` chr)
      (char= #\~ chr)))

(defun gap-separator-p (chr)
  (or (char= #\Newline chr)
      (char= #\Space chr)
      (char= #\Vt chr))  ; Vertical Tabulation
      (char= #\Page chr) ; Formfeed
      (char= #\Tab chr))

(defun except-symbol-p (chr)
  (char= #\- chr))

(defun first-quote-symbol-p (chr)
  (char= #\' chr))

(defun second-quote-symbol-p (chr)
  (char= #\" chr))

;; (defun repetition-symbol-p (chr)
;;   (char= #\* chr))
					
(defun special-sequence-symbol-p (chr)
  (char= #\? chr))

(defun terminal-character-p (chr-start &optional chr-end)
  (or (letter-p chr-start)
      (decimal-digit-p chr-start)
      (concatenate-symbol-p chr-start)
      (defining-symbol-p chr-start)
      (definition-separator-symbol-p chr-start)
      (start-comment-symbol-p chr-start chr-end)
      (end-comment-symbol-p chr-start chr-end)
      (start-group-symbol-p chr-start)
      (end-group-symbol-p chr-start)
      (start-option-symbol-p chr-start chr-end)
      (end-option-symbol-p chr-start chr-end)
      (start-repeat-symbol-p chr-start chr-end)
      (end-repeat-symbol-p chr-start chr-end)
      (except-symbol-p chr-start)
      (first-quote-symbol-p chr-start)
      (second-quote-symbol-p chr-start)
      (special-sequence-symbol-p chr-start)
      (terminator-symbol-p chr-start)
      (other-character-p chr-start)))

(defun first-terminal-character-p (&rest chars)
  ;; first terminal character = terminal character - first quote symbol;
  
  (and (not (first-quote-symbol-p (first chars)))
       (terminal-character-p (first chars) (second chars))))

(defun second-terminal-character-p (&rest chars)
  ;; second terminal character = terminal character - second quote symbol;
  
  (and (not (second-quote-symbol-p (first chars)))
       (terminal-character-p (first chars) (second chars))))

(defun terminal-string-p (&rest chars)
  ;; terminal string = first quote symbol, first terminal character, {first terminal character}, first quote symbol
  ;;                 | second quote symbol, second terminal character, {second terminal character}, second quote symbol;
  
  (or (and (first-quote-symbol-p (first chars))
	   (first-terminal-character-p (second chars))
	   (first-terminal-character-p (butlast (rest (rest chars))))
	   (first-quote-symbol-p (first (last chars))))
      (and (second-quote-symbol-p (first chars))
	   (second-terminal-character-p (second chars))
	   (second-terminal-character-p (butlast (rest (rest chars))))
	   (second-quote-symbol-p (first (last chars))))))

(defun gap-free-symbol-p (&rest chars)
  ;;  gap free symbol = terminal character - (first quote symbol | second quote symbol) | terminal string;
  
  (or (and (not (or (first-quote-symbol-p (first chars))
		    (second-quote-symbol-p (first chars))))
	   (terminal-character-p (first chars) (second chars)))
      (terminal-string-p chars)))

(defun syntax (&rest chars)
  (declare (ignore chars))
  ;;  syntax = {gap separator}, gap free symbol, {gap separator}, {gap free symbol, {gap separator}};
  )
