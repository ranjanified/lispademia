(in-package #:cl-dsa/tests)

(in-suite* char-map :in cl-dsa)

(def-fixture with-char-map-of (&rest words)
  (let* ((char-map (make-char-map words)))
    (&body)))

(test make-char-map
  (with-fixture with-char-map-of ("hello" "doodle" "do")
    (is-true char-map)))

(test char-map-depth
  (with-fixture with-char-map-of ("hello" "doodle" "do")
    (is-true (= (char-map-depth char-map) 6))))

(test member-char-map
  (with-fixture with-char-map-of ("hello" "doodle" "do")
    (is-true (member-char-map char-map "do"))
    (is-true (member-char-map char-map "h"))
    (is-true (member-char-map char-map "he"))
    (is-true (member-char-map char-map "hel"))
    (is-true (member-char-map char-map "hell"))
    (is-true (member-char-map char-map "hello"))
    
    (is-true (member-char-map char-map "d"))
    (is-true (member-char-map char-map "doo"))
    (is-true (member-char-map char-map "dood"))
    (is-true (member-char-map char-map "doodl"))
    (is-true (member-char-map char-map "doodle"))

    (is-true (member-char-map char-map "do"))
    
    (is-false (member-char-map char-map "hey-lo"))
    (is-false (member-char-map char-map "helo"))
    (is-false (member-char-map char-map "hello "))
    (is-false (member-char-map char-map "dooodle"))
    (is-false (member-char-map char-map "doodle "))))
