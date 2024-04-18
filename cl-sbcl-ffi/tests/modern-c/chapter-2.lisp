(in-package #:cl-sbcl-ffi/tests)

(in-suite* chapter-2 :in modern-c)

(def-fixture with-pun ()
  (with-alien ((pun-str (* char) (print-pun)))
    (with-alien ((printed-string c-string pun-str))
      (&body))
    (free-alien pun-str)))

(test print-pun
  (with-fixture with-pun ()
    (is-true (string= printed-string "To C, or not to C: that is the question."))))

(test dimensional-weight-of-box
  (is-true (zerop (dimensional-weight-of-box  0  0  0)))
  (is-true (=     (dimensional-weight-of-box  1  1  1)  1.0))
  (is-true (=     (dimensional-weight-of-box 12 10  8)  6.0))
  (is-true (=     (dimensional-weight-of-box 12 12 12) 11.0))
  (is-true (=     (dimensional-weight-of-box 12 15 18) 20.0)))

(test fahrenheit-to-celsius
  (is-true (string= (format nil "~6f" (fahrenheit-to-celsius   0.0)) "-17.78"))
  (is-true (string= (format nil "~6f" (fahrenheit-to-celsius 100.0)) "37.778"))
  (is-true (string= (format nil "~5f" (fahrenheit-to-celsius 212.0)) "100.0"))
  (is-true (= (fahrenheit-to-celsius 98.6) 37.0)))
