(defsystem "cl-dsa"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "utils"))))
  :description ""
  :in-order-to ((test-op (test-op "cl-dsa/tests"))))

(defsystem "cl-dsa/tests"
  :author ""
  :license ""
  :depends-on ("cl-dsa"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cl-dsa"
  :perform (test-op (op c) (print c) (symbol-call :fiveam :run! 'cl-exercises-tests)))
