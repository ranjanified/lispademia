(in-package #:cl-ebnf)

(defclass terminal-string ()
  (first-quote-symbol
   first-terminal-characters
   second-quote-symbol
   second-terminal-characters))

(defclass meta-identifier ()
  (meta-identifier-characters))

(defclass grouped-sequence ()
  (start-group-symbol
   definitions-list
   end-group-symbol))

(defclass repeated-sequence ()
  (start-repeat-symbol
   definitions-list
   end-repeat-symbol))

(defclass optional-sequence ()
  (start-option-symbol
   definitions-list
   end-option-symbol))

(defclass syntactic-primary ()
  (optional-sequence
   repeated-sequence
   grouped-sequence
   meta-identifier
   terminal-string
   special-sequence
   empty-sequence))

(defclass syntactic-factor ()
  (factor
   repetition-symbol
   syntactic-primary))

(defclass syntactic-exception ()
  ())

(defclass syntactic-term ()
  (syntactic-factor
   except-symbol
   syntactic-exception))

(defclass single-definition ()
  (syntactic-terms))

(defclass syntax-rule ()
  (meta-identifier
   defining-symbol
   definitions-list
   terminator))

(defclass syntax ()
  (syntax-rules))
