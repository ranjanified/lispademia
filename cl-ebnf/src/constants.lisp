(in-package #:cl-ebnf)

(defconstant +concatenate-symbol+ #\,
  "concatenates")

(defconstant +defining-symbol+ #\=
  "")

;;; characters forming comment symbol
(defconstant +start-comment-symbol-1+ #\(
  "")
(defconstant +start-comment-symbol-2+ #\*
  "")
(defconstant +end-comment-symbol-1+ #\*
  "")
(defconstant +end-comment-symbol-2+ #\)
  "")

;;; characters for definition-separator symbol
(defconstant +definition-separator-symbol-1+ #\|
  "separates definitions")
(defconstant +definition-separator-symbol-2+ #\/
  "separates definitions")
(defconstant +definition-separator-symbol-3+ #\!
  "separates definitions")

;;; characters for group symbol
(defconstant +start-group-symbol+ #\(
  "")
(defconstant +end-group-symbol+ #\)
  "")

;;; characters of or forming option symbol
(defconstant +start-option-symbol+ #\[
  "")
(defconstant +start-option-symbol-1+ #\(
  "")
(defconstant +start-option-symbol-2+ #\/
  "")
(defconstant +end-option-symbol+ #\]
  "")
(defconstant +end-option-symbol-1+ #\/
  "")
(defconstant +end-option-symbol-2+ #\)
  "")

;;; characters of or for forming repeat symbol
(defconstant +start-repeat-symbol+ #\{
  "")
(defconstant +start-repeat-symbol-1+ #\(
  "")
(defconstant +start-repeat-symbol-2+ #\:
  "")
(defconstant +end-repeat-symbol+ #\}
  "")
(defconstant +end-repeat-symbol-1+ #\:
  "")
(defconstant +end-repeat-symbol-2+ #\)
  "")

;;; character of except symbol
(defconstant +except-symbol+ #\-
  "")

;;; character of quote symbols
(defconstant +first-quote-symbol+ #\'
  "")
(defconstant +second-quote-symbol+ #\"
  "")

;;; character of repetition symbol
(defconstant +repetition-symbol+ #\*
  "")

;;; character of special-sequence symbol 
(defconstant +special-sequence-symbol+ #\?
  "")

;;; characters for terminator symbol
(defconstant +terminator-symbol-1+ #\;
  "")
(defconstant +terminator-symbol-2+ #\.
  "")
