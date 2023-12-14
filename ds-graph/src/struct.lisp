(in-package :ds-graph)

(defstruct (graph (:type vector))
  "Graph DS"
  (edges #() :type vector)
  (vertices #() :type vector))
