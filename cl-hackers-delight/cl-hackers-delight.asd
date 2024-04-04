(defsystem #:cl-hackers-delight
  :version "0.0.0"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "chapter-2"))))
  :description ""
  :in-order-to ((test-op (test-op #:cl-hackers-delight/tests))))

(defsystem #:cl-hackers-delight/tests
  :author ""
  :license ""
  :depends-on (#:cl-hackers-delight
               #:fiveam)
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:file "chapter-2"))))
  :description "Test system for cl-hackers-delight"
  :perform (test-op (op c) (symbol-call '#:cl-hackers-delight/tests '#:run-tests)))
