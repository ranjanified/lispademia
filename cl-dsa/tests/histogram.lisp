(in-package #:cl-dsa/tests)

(in-suite* histogram :in cl-dsa)

(test histogram-vertical
  (finishes (print-histogram-vertical #()))
  (finishes (print-histogram-vertical #(5 4 2))))
