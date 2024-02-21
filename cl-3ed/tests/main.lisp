(defpackage #:cl-3ed/tests
  (:shadowing-import-from #:cl-3ed #:first #:rest #:evenp)
  (:use #:cl
        #:cl-3ed
        #:fiveam)
  (:export #:run-tests))

(in-package #:cl-3ed/tests)
(def-suite cl-3ed-suite)

(defun run-tests ()
  (fiveam:run! 'cl-3ed-suite))
