(defsystem #:cl-dsa
  :version "0.1.0"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "utils")
		 (:file "histogram")
		 (:file "count-blanks")
		 (:file "strings"))))
  :description ""
  :in-order-to ((test-op (test-op #:cl-dsa/tests))))

(defsystem #:cl-dsa/tests
  :author "Nalin Ranjan"
  :license ""
  :depends-on (#:cl-dsa
               #:fiveam)
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:file "histogram")
		 (:file "count-blanks")
		 (:file "strings"))))
  :description "Test system for cl-dsa"
  :perform (test-op (op system) (symbol-call '#:cl-dsa/tests '#:run-tests)))
