(defsystem :cl-pcl
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")))
	       (:module "src/cd-records"
		:components
		((:file "factory")
		 (:file "db"))))
  :description ""
  :in-order-to ((test-op (test-op :cl-pcl/tests))))

(defsystem :cl-pcl/tests
  :author ""
  :license ""
  :depends-on (:cl-pcl :fiveam)
  :components ((:module "tests"
		:serial t
                :components
                ((:file "main")
		 (:module "cd-records"
		  :components
		  ((:file "suite")
		   (:file "db")
		   (:file "factory"))))))
  :description "Test system for pcl"
  :perform (test-op (op c) (print c) (symbol-call :fiveam :run-all-tests)))
