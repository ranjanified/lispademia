(defsystem #:cl-ebnf
  :version "0.0.1"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "conditions")
		 (:file "constants")
		 (:file "predicates")
		 (:file "lexer")
		 (:file "clossy-lex"))))
  :description ""
  :in-order-to ((test-op (test-op #:cl-ebnf/tests))))

(defsystem #:cl-ebnf/tests
  :author "Nalin Ranjan"
  :license ""
  :depends-on (#:cl-ebnf
               #:fiveam)
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:file "lexer"))))
  :description "Test system for cl-ebnf"
  :perform (test-op (op sys) (symbol-call '#:cl-ebnf/tests '#:run-tests)))
