(defsystem #:cl-3ed
  :version "0.0.1"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "Lisp 3rd edition By Patrick H Winston"
  :in-order-to ((test-op (test-op "cl-3ed/tests"))))

(defsystem #:cl-3ed/tests
  :author "Nalin Ranjan"
  :license ""
  :depends-on (#:cl-3ed
               #:fiveam)
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:file "chapter2"))))
  :description "Test system for cl-3ed"
  :perform (test-op (op c) (symbol-call '#:cl-3ed/tests '#:run-tests)))
