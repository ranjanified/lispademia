(in-package #:cl-dsa/tests)

(in-suite* weather-report :in cl-dsa-tests)

(test print-report
  (finishes (weather-report #()))
  (finishes (weather-report #(#(90 37.3))))
  (finishes (weather-report #(#(90 37.3) #(-90 44))))
  (finishes (weather-report #(#(90 37.3) #(-90 37.3))))
  (finishes (weather-report #(#(2 90) #(-2 50) #(4 50) #(-90 77) #(90 66.44) #(-90 18)))))
