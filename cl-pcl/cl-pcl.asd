(defsystem #:cl-pcl
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "utils")
		 (:module "cd-records"
		  :components
			  ((:file "factory")
			   (:file "db")))
		 (:module "id3-parser"
		  :components
			  ((:file "utils")
			   (:file "id3"))))))
  :description ""
  :in-order-to ((test-op (test-op #:cl-pcl/tests))))

(defsystem #:cl-pcl/tests
  :author ""
  :license ""
  :depends-on (#:cl-pcl #:fiveam)
  :components ((:module "tests"
		:serial t
                :components
                ((:file "main")
		 ;; (:module "cd-records"
		 ;;  :components
		 ;;  ((:file "suite")
		 ;;   (:file "db")
		 ;;   (:file "factory")))
		 (:module "id3-parser"
		  :components
		  ((:file "utils")
		   (:file "setup"))))))
  :description "Test system for pcl"
  :perform (test-op (op system) (symbol-call '#:cl-pcl/tests '#:run-tests)))
