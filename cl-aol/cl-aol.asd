(defsystem "cl-aol"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "chapter1"))))
  :description "Anatomy of Lisp"
  :in-order-to ((test-op (test-op "cl-aol/tests"))))

(defsystem "cl-aol/tests"
  :author ""
  :license ""
  :depends-on ("cl-aol"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:file "chapter1"))))
  :description "Test system for cl-aol"
  :perform (test-op (op c) (symbol-call :fiveam :run-all-tests)))
