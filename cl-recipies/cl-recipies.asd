(defsystem :cl-recipies
  :version "0.0.1"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "chapter1"))))
  :description "Common Lisp Recipies - The Book"
  :in-order-to ((test-op (test-op :cl-recipies/tests))))

(defsystem :cl-recipies/tests
  :author "Nalin Ranjan"
  :license ""
  :depends-on (:cl-recipies
               :fiveam)
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:file "chapter1"))))
  :description "Test system for cl-recipies"
  :perform (test-op (op c) (symbol-call :fiveam :run! :cl-recipies/tests)))
