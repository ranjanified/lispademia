(in-package #:cl-dsa/tests)

(in-suite* department-sales :in cl-dsa)

(test print-department-sales
  (finishes (print-department-sales #()))
  (finishes (print-department-sales #(#(0 0 0) #(0 0 0))))
  (finishes (print-department-sales #(#(1 1 0) #(2 1 0) #(20 10 0))))
  (finishes (print-department-sales #(#(1 1 10000) #(20 10 40000) #(19 10 0))))

  (loop :repeat 1000
	:collect (vector (random 21) (random 11) (random 100000)) :into sale-cards
	:finally (finishes (print-department-sales (coerce sale-cards 'simple-vector)))))
