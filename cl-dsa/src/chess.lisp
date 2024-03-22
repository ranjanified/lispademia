;;;; Show how a checkboard can be represented by an array. Show how to represent the state of a game of checkers at a particular instant.
;;;; Write a function that takes as an input an array representing such a checkboard, and prints all possible moves that black can make from
;;;; that position

(in-package #:cl-dsa)

(defun make-chess-board (&key (black-box #\b) (white-box #\w) (black-piece #\*) (white-piece #\!))
  (loop
    :with chess-board := (make-array '(8 8) :initial-element #\Space)
    :with max-rows := (array-dimension chess-board 0)
    :with max-cols := (array-dimension chess-board 1)
    :for row-index :from 0 :below max-rows 
    :when (< row-index 2)
      :do ;; arrange all the black pieces
	  (loop :for col-index :from 0 :below max-cols
		:do (setf (aref chess-board row-index col-index) black-piece))
    :when (> row-index 5)
      :do ;; arrange all the white pieces
	  (loop :for col-index :from 0 :below max-cols
		:do (setf (aref chess-board row-index col-index) white-piece))
    :when (and (> row-index 1) (< row-index 6))
      :do ;; mark the boxes, alternating black and white
	  (loop :for col-index :from 0 :below max-cols
		:if (evenp row-index)
		  :do (setf (aref chess-board row-index col-index) (if (evenp col-index) black-box white-box))
		:else
		  :do (setf (aref chess-board row-index col-index) (if (evenp col-index) white-box black-box)))
    :finally (return chess-board)))
