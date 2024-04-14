;;;; Show how a checkboard can be represented by an array. Show how to represent the state of a game of checkers at a particular instant.
;;;; Write a function that takes as an input an array representing such a checkboard, and prints all possible moves that black can make from
;;;; that position

(in-package #:cl-dsa)

(defvar *chess-symbols* #(#(#:white-chess-king #\U+2654)
			       #(#:white-chess-queen #\U+2655)
			       #(#:white-chess-rook #\U+2656)
			       #(#:white-chess-bishop #\U+2657)
			       #(#:white-chess-knight #\U+2658)
			       #(#:white-chess-pawn #\U+2659)

			       #(#:black-chess-king #\U+265A)
			       #(#:black-chess-queen #\U+265B)
			       #(#:black-chess-rook #\U+265C)
			       #(#:black-chess-bishop #\U+265D)
			       #(#:black-chess-knight #\U+265E)
			       #(#:black-chess-pawn #\U+265F)))

(defun get-chess-character (chess-symbol)
  (loop
    :with selected-chess-symbol
    :for chess-symbol-entry :across *chess-symbols*
    :when (string= (symbol-name chess-symbol) (symbol-name (svref chess-symbol-entry 0)))
      :do (return (svref chess-symbol-entry 1))))

(defun print-chess-board (chess-board)
  (pprint-logical-block (*terminal-io* nil)
    ;; (pprint-indent :block 12 *terminal-io*)
    ;; (pprint-newline :mandatory *terminal-io*)
    (loop
      :with row-dimension := (array-dimension chess-board 0)
      :and col-dimension := (array-dimension chess-board 1)
      :for row-index :from 0 :below row-dimension
      :do (loop :for col-index :from 0 :below col-dimension
		:do (write-char (aref chess-board row-index col-index) *terminal-io*)
		    (pprint-tab :line-relative col-index 8 *terminal-io*))
	  (pprint-newline :mandatory *terminal-io*)
      ))
  (values))

(defun make-chess-board (&key (black-box #\U+25A0) (white-box #\U+25A1))
  (loop
    :with chess-board := (make-array '(8 8) :initial-element #\Space)
    :with max-rows := (array-dimension chess-board 0)
    :with max-cols := (array-dimension chess-board 1)
    :for row-index :from 0 :below max-rows 
    :when (= row-index 0)
      :do ;; arrange all the black pieces
	  (setf (aref chess-board row-index 0) (get-chess-character '#:black-chess-rook))
	  (setf (aref chess-board row-index 1) (get-chess-character '#:black-chess-knight))
	  (setf (aref chess-board row-index 2) (get-chess-character '#:black-chess-bishop))
	  (setf (aref chess-board row-index 3) (get-chess-character '#:black-chess-queen))
	  (setf (aref chess-board row-index 4) (get-chess-character '#:black-chess-king))
	  (setf (aref chess-board row-index 5) (get-chess-character '#:black-chess-bishop))
	  (setf (aref chess-board row-index 6) (get-chess-character '#:black-chess-knight))
	  (setf (aref chess-board row-index 7) (get-chess-character '#:black-chess-rook))
    :when (= row-index 1)
      :do (loop :for col-index :from 0 :below max-cols
		:do (setf (aref chess-board row-index col-index) (get-chess-character '#:black-chess-pawn)))
    :when (= row-index 6)
      :do ;; arrange all the white pieces
	  (loop :for col-index :from 0 :below max-cols
		:do (setf (aref chess-board row-index col-index) (get-chess-character '#:white-chess-pawn)))
    :when (= row-index 7)
      :do ;; arrange all the black pieces
	  (setf (aref chess-board row-index 0) (get-chess-character '#:white-chess-rook))
	  (setf (aref chess-board row-index 1) (get-chess-character '#:white-chess-knight))
	  (setf (aref chess-board row-index 2) (get-chess-character '#:white-chess-bishop))
	  (setf (aref chess-board row-index 3) (get-chess-character '#:white-chess-queen))
	  (setf (aref chess-board row-index 4) (get-chess-character '#:white-chess-king))
	  (setf (aref chess-board row-index 5) (get-chess-character '#:white-chess-bishop))
	  (setf (aref chess-board row-index 6) (get-chess-character '#:white-chess-knight))
	  (setf (aref chess-board row-index 7) (get-chess-character '#:white-chess-rook))
    :when (and (> row-index 1) (< row-index 6))
      :do ;; mark the boxes, alternating black and white
	  (loop :for col-index :from 0 :below max-cols
		:if (evenp row-index)
		  :do (setf (aref chess-board row-index col-index) (if (evenp col-index) white-box black-box))
		:else
		  :do (setf (aref chess-board row-index col-index) (if (evenp col-index) black-box white-box)))
    :finally (return chess-board)))

;; (defun set-chess-character (chess-symbol chess-board row-num col-num)
;;   (setf (aref chess-board row-index col-index) (or (get-chess-character chess-symbol)
;; 						   )))
