(defsystem #:cl-sbcl-ffi
  :version "0.0.1"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:module "modern-c"
		  :components
		  ((:file "chapter2")
		   (:file "chapter3")
		   (:file "chapter4")
		   (:file "chapter5")))
		 (:module "c-algorithms"
		  :components
		  ((:file "chapter-2"))))))
  :Description ""
  :in-order-to ((load-op (load-op #:cl-sbcl-ffi/c-bridge))
		(test-op (test-op #:cl-sbcl-ffi/tests))))

(defsystem #:cl-sbcl-ffi/c-bridge
  :version "0.0.1"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :description ""
  :perform (load-op (op sys)
		    (let ((shared-object-filename "libsbclffi.so"))
		      (sb-alien:unload-shared-object
		       (system-relative-pathname (component-name sys) shared-object-filename))
		      (sb-alien:load-shared-object
		       (system-relative-pathname (component-name sys) shared-object-filename)))))

(defsystem #:cl-sbcl-ffi/tests
  :author "Nalin Ranjan"
  :license ""
  :depends-on (#:cl-sbcl-ffi)
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:module "modern-c"
		  :components
		  ((:file "chapter-2")))
		 (:module "c-algorithms"
		  :components
		  ((:file "chapter-2"))))))
  :description "Test system for cl-sbcl-ffi"
  :perform (test-op (op c) (symbol-call '#:cl-sbcl-ffi/tests '#:run-tests)))
