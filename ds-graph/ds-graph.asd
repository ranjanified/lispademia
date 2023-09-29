(defsystem "ds-graph"
  :version "0.0.1"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "struct"))))
  :description "Graphs"
  :in-order-to ((test-op (test-op "ds-graph/tests"))))

(defsystem "ds-graph/tests"
  :author ""
  :license ""
  :depends-on ("ds-graph"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for ds-graph"
  :perform (test-op (op c) (symbol-call :fiveam :run-all-tests)))
