(defsystem :cl-aia
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "chapter1"))))
  :description ""
  :in-order-to ((test-op (test-op "cl-aia/tests"))))

(defsystem :cl-aia/tests
  :author ""
  :license ""
  :depends-on (:cl-aia
               :fiveam)
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:file "chapter1"))))
  :description "Test system for cl-aia"
  :perform (test-op (op c) (symbol-call :fiveam :run-all-tests)))
