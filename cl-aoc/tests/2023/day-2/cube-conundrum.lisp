(in-package :cl-aoc/tests/main)

(in-suite aoc-2023)

(test cube-conundrum
  (let ((color-config (list 12 13 14))
	(example-game-strings '("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
			       "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
			       "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
			       "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
			       "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green")))
    (is-true (zerop (cube-conundrum color-config '())))
    (is-true (zerop (cube-conundrum color-config '(""))))
    (is-true (= 8 (cube-conundrum color-config example-game-strings)))
    (is (= 2512 (cube-conundrum color-config
				 (uiop:read-file-lines
				  (merge-pathnames (asdf:system-relative-pathname "cl-aoc" "tests/2023/day-2/")
						   #P"input.txt")))))))
