(defsystem "cl-exercises"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "50-coding-challenges"))))
  :description ""
  :in-order-to ((test-op (test-op "cl-exercises/tests"))))

(defsystem "cl-exercises/tests"
  :author ""
  :license ""
  :depends-on ("cl-exercises"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:file "50-coding-challenges"))))
  :description "Test system for cl-exercises"
  :perform (test-op (op c) (symbol-call :fiveam :run! :cl-exercises-tests)))
