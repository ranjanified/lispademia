(defsystem "lispademia"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("cl-pcl"
	       "cl-aia"
	       "cl-aol"
	       "ds-graph"
	       "cl-aoc"
	       "cl-exercises")
  :description ""
  :in-order-to ((test-op (test-op "lispademia/tests"))))

(defsystem "lispademia/tests"
  :author ""
  :license ""
  :depends-on ("cl-pcl/tests"
	       "cl-aia/tests"
	       "cl-aol/tests"
	       "ds-graph/tests"
	       "cl-aoc/tests"
	       "cl-exercises/tests")
  :description "Test system for lispademia"
  :perform (test-op (op c) (symbol-call :fiveam :run-all-tests)))
