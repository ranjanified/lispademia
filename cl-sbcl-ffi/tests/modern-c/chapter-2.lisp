(in-package #:cl-sbcl-ffi/tests)

(in-suite* modc-chapter-2 :in modern-c)

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

(def-fixture with-fahrenheit (fahr)
  (let ((celsius (/ (ffloor (* (fahrenheit-to-celsius fahr) 100)) 100)))
    (&body)))

(test fahrenheit-to-celsius
  (with-fixture with-fahrenheit (0.0)
    (is-true (= celsius -17.78)))
  
  (with-fixture with-fahrenheit (100.0)
    (is-true (= celsius 37.77)))
  
  (with-fixture with-fahrenheit (212.0)
    (is-true (= celsius 100.00)))
  
  (with-fixture with-fahrenheit (98.6)
    (is-true (= celsius 37.00))))

(def-fixture with-sphere-radius (radius)
  (let ((volume (/ (ffloor (* (sphere-volume radius) 100)) 100)))
    (&body)))

(test sphere-volume
  (is-true (zerop (sphere-volume 0.0)))

  (with-fixture with-sphere-radius (1.0)
    (is-true (= volume 4.18))))

(test taxed-dollars
  (is-true (zerop (taxed-dollars 0.0 100.0)))
  (is-true (=     (taxed-dollars 100.0 0.0) 100.0))
  (is-true (=     (taxed-dollars 100.0 5.0) 105.0)))
