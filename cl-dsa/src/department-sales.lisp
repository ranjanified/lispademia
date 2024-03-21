;;;; write a program for a chain of 20 department stores, each of which sells 10 different items. Every month, each store manager submits a data
;;;; card for each item consisting of a branch number (from 1 to 20), an item number (from 1 to 10) and a sales figure (less than $1,00,000)
;;;; representing the amount of sales for that item in that branch. However, some managers may not submit cards for some items (for example, not
;;;; all items are sold in all branches). You are to write a C program to read these data cards, and print a table with 12 columns. The first
;;;; column should contain the branch numbers from 1 to 20 and the word "TOTAL" in the last line. The next 10 columns should contain the sales
;;;; figures for each of the 10 items for each of the branches, with the total sales of each item in the last line. The last column should contain
;;;; the total sales of each of the 20 branches for all items, with the grand total sales figure for the chain in the lower right-hand corner.
;;;; Each column should have an appropriate heading. If no sales were reported for a particular branch and item, assume zero sales. Do not assume
;;;; that your input is in any particular order.

(in-package #:cl-dsa)

(defun print-department-sales (sale-cards)
  ;; (declare (type (simple-array (integer 0 *) 3) sale-cards))
  (loop 
    :initially ;; Put the cards in the table
	       (loop
		 :initially (fresh-line)
			    (pprint-logical-block (*standard-output* nil)
			      (write-string (string-capitalize "department"))
			      (pprint-tab :section 0 16)
			      (loop :for i :from 1 :to (array-dimension sales-table 1)
				    :do (write-string (string-capitalize (format nil "item-~a" i)))
				    :do (pprint-tab :line i 4))
			      (write-string (string-capitalize "total sales"))
			      (pprint-newline :mandatory))
		 :for sale-card :across sale-cards
		 :for department-index := (svref sale-card 0) :then (svref sale-card 0)
		 :for item-index := (svref sale-card 1) :then (svref sale-card 1)
		 :for sale-figure := (svref sale-card 2) :then (svref sale-card 2)
		 :when (and (> department-index 0) (<= department-index (array-dimension sales-table 0))
			    (> item-index 0) (<= item-index (array-dimension sales-table 1)))
		   :do (setf (aref sales-table (1- department-index) (1- item-index)) sale-figure))
    :with sales-table := (make-array '(20 10) :initial-element 0)
    :with store-total := 0
    :repeat 1
    :do ;; print department-wise item sales and total sales
	(loop :for department-index :from 0 :below (array-dimension sales-table 0)
	      :for department-total := 0 :then 0
	      :do (fresh-line)
		  (pprint-logical-block (*standard-output* nil :prefix "" :suffix "")
		    (pprint-indent :block -3)
		    (write-string (format nil "Dept-~a" (1+ department-index)))
		    (pprint-tab :line 0 16))
		  (pprint-logical-block (*standard-output* nil :prefix "" :suffix "")
		    (loop :for item-index :from 0 :below (array-dimension sales-table 1)
			  :do (incf department-total (aref sales-table department-index item-index))
			      (write-string (format nil "~a" (aref sales-table department-index item-index)))
			      (pprint-tab :line (1+ item-index) 8))
		    (write-string (format nil "~a" department-total))))
    :finally ;; print footer
	     (fresh-line)
	     (pprint-logical-block (*standard-output* nil :prefix "" :suffix "")
	       (pprint-indent :block -3)
	       (pprint-newline :mandatory)
	       (write-string "Total")
	       (pprint-tab :line 0 16))
	     
	     ;; Print items and total
	     (pprint-logical-block (*standard-output* nil :prefix "" :suffix "")
	       (loop
		 :for item-index :from 0 :below (array-dimension sales-table 1)
		 :do (write-string (format nil "~a" (loop :for dept-index :from 0 :below (array-dimension sales-table 0)
							  :sum (aref sales-table dept-index item-index)
							  :do (incf store-total (aref sales-table dept-index item-index)))))
		     (pprint-tab :line (1+ item-index) 8))
	       ;; print total
	       (write-string (format nil "~a" store-total)))
	     (fresh-line)))
