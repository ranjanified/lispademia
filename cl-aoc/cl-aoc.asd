(defsystem "cl-aoc"
  :version "0.0.1"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:module "2023"
		  :components
		  ((:module "day-1"
		    :components
			    ((:file "trebuchet"))))))))
  :description "Advent of Code"
  :in-order-to ((test-op (test-op "cl-aoc/tests"))))

(defsystem "cl-aoc/tests"
  :author ""
  :license ""
  :depends-on ("cl-aoc"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "main")
		 (:module "2023"
		  :components
		  ((:module "day-1"
		    :components
			    ((:file "trebuchet"))))))))
  :description "Test system for cl-aoc"
  :perform (test-op (op c) (symbol-call :fiveam :run-all-tests)))
