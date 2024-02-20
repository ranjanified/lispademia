(in-package #:cl-3ed/tests)

(in-suite* chapter2 :in cl-3ed-suite)

(defun s-expression-p (exp)
  (or (atom exp) (consp exp)))

(test 2.1-expression-classification
  (is-true (atom 'atom))
  
  (is-false (atom '(this is an atom)))
  (is-true (s-expression-p '(this is an atom)))

  (is-false (atom '((a b) (c d))))
  (is-true (listp '((a b) (c d))))
  (is-true (s-expression-p '((a b) (c d))))

  (is-true (atom 3))

  (is-true (listp '(3)))
  (is-true (s-expression-p '(3)))

  (is-true (listp (list 3)))

  (is-true (atom (/ (1+ 3) (1- 3)))))

(test 2.2-eval-expressions
  (is-true (= 2 (/ (1+ 3) (1- 3))))
  (is-true (= 15 (* (max 3 4 5) (min 3 4 5))))
  (is-true (= (min (max 3 1 4) (max 2 7 1)))))

(test 2.3-eval-expressions
  (is-true (eql 'P (car '(P H W))))
  (is-true (eql '(K P H) (cdr '(B K P H))))
  (is-true (eql '(A B) (car '((A B) (C D)))))
  (is-true (eql '((C D)) (cdr '((A B) (C D)))))
  (is-true (eql '(C D) (car (cdr '((A B) (C D))))))
  (is-true (eql '(B) (cdr (car '((A B) (C D))))))
  (is-true (eql '(D) (cdr (car (cdr '((A B) (C D)))))))
  (is-true (eql 'B (car (cdr (car '((A B) (C D))))))))

(test 2.4-eval-expressions
  (prog ((input-expression '((A B) (C D) (E F))))
     (is-true (eql 'D (car (cdr (car (cdr input-expression))))))
     (is-true (eql 'E (car (car (cdr (cdr input-expression))))))
     (is-true (eql 'D (car (cdr (car (cdr input-expression))))))
     (is-true (equal '(A B) (car (car (cdr '(cdr ((A B) (C D) (E F))))))))

     ;; The simplified expression is (car 'cdr), and which signals type-error
     (signals type-error (car (car '(cdr (cdr ((A B) (C D) (E F)))))))
     (is-true (eql 'car (car '(car (cdr (cdr ((A B) (C D) (E F))))))))
     (is-true (eql '(car (car (cdr (cdr ((A B) (C D) (E F)))))) '(car (car (cdr (cdr ((A B) (C D) (E F))))))))))

(test 2.5-pick-pear
  (is-true (eql 'pear (car (cdr (cdr '(apple orange pear grapefruit))))))
  (is-true (eql 'pear (car (car (cdr '((apple orange) (pear grapefruit)))))))
  (is-true (eql 'pear (car (car (cdr (cdr (car '(((apple) (orange) (pear) (grapefruit))))))))))
  (is-true (eql 'pear (car (car (cdr (cdr (car '(((apple) (orange) (pear) (grapefruit))))))))))
  (is-true (eql 'pear (car (car (car (cdr (cdr '(apple (orange) ((pear)) (((grapefruit)))))))))))
  (is-true (eql 'pear (car (car (cdr (cdr '((((apple))) ((orange)) (pear) grapefruit)))))))
  (is-true (eql 'pear (car (cdr (car '((((apple) orange) pear) grapefruit)))))))

(test 2.6-eval-expressions
  (progv '(tools) ()
    ;; expression
    (set 'tools (list 'hammer 'screwdriver))
    (cons 'pliers (symbol-value 'tools))

    ;; assertion
    (is-true (equal '(hammer screwdriver) (symbol-value 'tools)))

    ;; expression
    (set 'tools (cons 'pliers (symbol-value 'tools)))

    ;; assertion
    (is-true (equal '(pliers hammer screwdriver) (symbol-value 'tools)))

    ;; expression
    (append '(saw wrench) (symbol-value 'tools))

    ;; assertion
    (is-true (equal '(pliers hammer screwdriver) (symbol-value 'tools)))

    ;; expression
    (set 'tools (append '(saw wrench) (symbol-value 'tools)))

    ;; assertion
    (is-true (equal '(saw wrench pliers hammer screwdriver) (symbol-value 'tools)))))
