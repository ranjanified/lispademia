(in-package #:cl-ebnf/tests)

(in-suite* cl-ebnf-tests)

(test lex-empty-string
  (is-true (null (lex "")))
  (is-true (null (lex "   " ))))

(test lex-comments
  (is-true (equal (lex "(**)" ) '((:comment ""))))

  ;; whitespaces inside comment are preserved
  (is-true (equal (lex "(*   *)" ) '((:comment "   "))))
  (is-true (equal (lex "(*123*)" ) '((:comment "123"))))
  (is-true (equal (lex "(*  123 456   *)" ) '((:comment "  123 456   "))))
  (signals end-of-file (lex "(*  123 456" ))  ; we need a condition of our own here
  (signals end-of-file (lex "(*123 456   " )) ; we need a condition of our own here
  (is-true (equal (lex "(*123 (*456*)" ) '((:comment "123 (*456"))))
  (is-true (equal (lex "(*123*) (*456*)" ) '((:comment "123") (:comment "456")))))

(test lex-options
  (is-true (equal (lex "(//)" ) '((:option nil))))
  (is-true (equal (lex "(/    /)" ) '((:option nil))))
  (is-true (equal (lex "   (/    /)" ) '((:option nil))))
  (is-true (equal (lex "(/    /)   " ) '((:option nil))))
  (is-true (equal (lex "(//)    " ) '((:option nil))))
  (is-true (equal (lex "   (/    /)    " ) '((:option nil))))
  (is-true (equal (lex "(/1/)" ) '((:option ((:unknown "1"))))))
  (is-true (equal (lex "(/1 2/)" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(/1      2/)" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(/    1 2/)" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(/1 2    /)" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(/   1   2    /)" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(/1 2 3 4/)" ) '((:option ((:unknown "1") (:unknown "2") (:unknown "3") (:unknown "4"))))))
  (is-true (equal (lex "(/1 2 3 (/4/)/)" ) '((:option ((:unknown "1") (:unknown "2") (:unknown "3") (:option ((:unknown "4"))))))))
  (is-true (equal (lex "(/(//) 1 2 3/)" ) '((:option ((:option nil) (:unknown "1") (:unknown "2") (:unknown "3"))))))
  (is-true (equal (lex "(/(/1/) (/2 3/)/)" ) '((:option ((:option ((:unknown "1"))) (:option ((:unknown "2") (:unknown "3"))))))))
  (signals malformed-token (lex "(/" ))
  (signals malformed-token (lex "(//" ))
  (signals malformed-token (lex "(/)" ))
  (signals malformed-token (lex "(/  ||" ))
  (signals malformed-token (lex "(/ /*" ))
  (signals malformed-token (lex "(/(/1 2 3/) 4 5" ))
  (signals malformed-token (lex "(/(/1 2 3/) (/4 5/)" ))
  (signals malformed-token (lex "(/(/(/1 2 3/) (/4/) 5/)" ))

  ;; with [] as option symbols
  (is-true (equal (lex "[]" ) '((:option nil))))
  (is-true (equal (lex "[    ]" ) '((:option nil))))
  (is-true (equal (lex "   [    ]" ) '((:option nil))))
  (is-true (equal (lex "[]    " ) '((:option nil))))
  (is-true (equal (lex "   [    ]    " ) '((:option nil))))
  (is-true (equal (lex "[1]" ) '((:option ((:unknown "1"))))))
  (is-true (equal (lex "[1 2]" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "[1      2]" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "[    1 2]" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "[1 2    ]" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "[   1   2    ]" ) '((:option ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "[1 2 3 4]" ) '((:option ((:unknown "1") (:unknown "2") (:unknown "3") (:unknown "4"))))))
  (is-true (equal (lex "[1 2 3 [4]]" ) '((:option ((:unknown "1") (:unknown "2") (:unknown "3") (:option ((:unknown "4"))))))))
  (is-true (equal (lex "[[] 1 2 3]" ) '((:option ((:option nil) (:unknown "1") (:unknown "2") (:unknown "3"))))))
  (is-true (equal (lex "[[1] [2 3]]" ) '((:option ((:option ((:unknown "1"))) (:option ((:unknown "2") (:unknown "3"))))))))
  (signals malformed-token (lex "[" ))
  (signals malformed-token (lex "[/" ))
  (signals malformed-token (lex "[)" ))
  (signals malformed-token (lex "[  ||" ))
  (signals malformed-token (lex "[ /*" ))
  (signals malformed-token (lex "[[1 2 3] 4 5" ))
  (signals malformed-token (lex "[[1 2 3] [4 5]" ))
  (signals malformed-token (lex "[[[1 2 3] [4] 5]" )))

(test lex-repeat
  (is-true (equal (lex "(::)" ) '((:repeat nil))))
  (is-true (equal (lex "(:    :)" ) '((:repeat nil))))
  (is-true (equal (lex "   (:    :)" ) '((:repeat nil))))
  (is-true (equal (lex "(::)    " ) '((:repeat nil))))
  (is-true (equal (lex "   (:    :)    " ) '((:repeat nil))))
  (is-true (equal (lex "(:1:)" ) '((:repeat ((:unknown "1"))))))
  (is-true (equal (lex "(:1 2:)" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(:1      2:)" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(:    1 2:)" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(:1 2    :)" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(:   1   2    :)" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(:1 2 3 4:)" ) '((:repeat ((:unknown "1") (:unknown "2") (:unknown "3") (:unknown "4"))))))
  (is-true (equal (lex "(:1 2 3 (:4:):)" ) '((:repeat ((:unknown "1") (:unknown "2") (:unknown "3") (:repeat ((:unknown "4"))))))))
  (is-true (equal (lex "(:(::) 1 2 3:)" ) '((:repeat ((:repeat nil) (:unknown "1") (:unknown "2") (:unknown "3"))))))
  (is-true (equal (lex "(:(:1:) (:2 3:):)" ) '((:repeat ((:repeat ((:unknown "1"))) (:repeat ((:unknown "2") (:unknown "3"))))))))
  (signals malformed-token (lex "(:" ))
  (signals malformed-token (lex "(::" ))
  (signals malformed-token (lex "(:)" ))
  (signals malformed-token (lex "(:  ||" ))
  (signals malformed-token (lex "(: :*" ))
  (signals malformed-token (lex "(:(:1 2 3:) 4 5" ))
  (signals malformed-token (lex "(:(:1 2 3:) (:4 5:)" ))
  (signals malformed-token (lex "(:(:(:1 2 3:) (:4:) 5:)" ))

  ;; with {} as repeat symbols
  (is-true (equal (lex "{}" ) '((:repeat nil))))
  (is-true (equal (lex "{    }" ) '((:repeat nil))))
  (is-true (equal (lex "   {    }" ) '((:repeat nil))))
  (is-true (equal (lex "{}    " ) '((:repeat nil))))
  (is-true (equal (lex "   {    }    " ) '((:repeat nil))))
  (is-true (equal (lex "{1}" ) '((:repeat ((:unknown "1"))))))
  (is-true (equal (lex "{1 2}" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "{1      2}" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "{    1 2}" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "{1 2    }" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "{   1   2    }" ) '((:repeat ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "{1 2 3 4}" ) '((:repeat ((:unknown "1") (:unknown "2") (:unknown "3") (:unknown "4"))))))
  (is-true (equal (lex "{1 2 3 {4}}" ) '((:repeat ((:unknown "1") (:unknown "2") (:unknown "3") (:repeat ((:unknown "4"))))))))
  (is-true (equal (lex "{{} 1 2 3}" ) '((:repeat ((:repeat nil) (:unknown "1") (:unknown "2") (:unknown "3"))))))
  (is-true (equal (lex "{{1} {2 3}}" ) '((:repeat ((:repeat ((:unknown "1"))) (:repeat ((:unknown "2") (:unknown "3"))))))))
  (signals malformed-token (lex "{" ))
  (signals malformed-token (lex "{/" ))
  (signals malformed-token (lex "{)" ))
  (signals malformed-token (lex "{  ||" ))
  (signals malformed-token (lex "{ /*" ))
  (signals malformed-token (lex "{{1 2 3} 4 5" ))
  (signals malformed-token (lex "{{1 2 3} {4 5}" ))
  (signals malformed-token (lex "{{{1 2 3} {4} 5}" )))

(test lex-groups
  (is-true (equal (lex "()" ) '((:group nil))))
  (is-true (equal (lex "(    )" ) '((:group nil))))
  (is-true (equal (lex "   (    )" ) '((:group nil))))
  (is-true (equal (lex "()    " ) '((:group nil))))
  (is-true (equal (lex "   (    )    " ) '((:group nil))))
  (is-true (equal (lex "(1)" ) '((:group ((:unknown "1"))))))
  (is-true (equal (lex "(1 2)" ) '((:group ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(1      2)" ) '((:group ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(    1 2)" ) '((:group ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(1 2    )" ) '((:group ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(   1   2    )" ) '((:group ((:unknown "1") (:unknown "2"))))))
  (is-true (equal (lex "(1 2 3 4)" ) '((:group ((:unknown "1") (:unknown "2") (:unknown "3") (:unknown "4"))))))
  (is-true (equal (lex "(1 2 3 (4))" ) '((:group ((:unknown "1") (:unknown "2") (:unknown "3") (:group ((:unknown "4"))))))))
  (is-true (equal (lex "(() 1 2 3)" ) '((:group ((:group nil) (:unknown "1") (:unknown "2") (:unknown "3"))))))
  (is-true (equal (lex "((1) (2 3))" ) '((:group ((:group ((:unknown "1"))) (:group ((:unknown "2") (:unknown "3"))))))))
  (is-true (equal (lex "(\"0\")") '((:group ((:quoted-symbol "0"))))))
  (is-true (equal (lex "(\" \" | \"0\")") '((:group ((:quoted-symbol " ") (:definition-separator) (:quoted-symbol "0"))))))
  (is-true (equal (lex "(character - (\" \" | \"0\"))")
		  '((:group ((:unknown "character") (:exception)
			     (:group ((:quoted-symbol " ") (:definition-separator) (:quoted-symbol "0"))))))))
  (signals malformed-token (lex "((1 2 3) 4 5" ))
  (signals malformed-token (lex "((1 2 3) (4 5)" ))
  (signals malformed-token (lex "(((1 2 3) (4) 5)" )))

(test lex-definition
  (is-true (equal (lex "=" ) '((:definition))))
  (is-true (equal (lex "==" ) '((:definition)(:definition))))
  (is-true (equal (lex "a = b" ) '((:unknown "a")(:definition) (:unknown "b"))))
  (is-true (equal (lex "a = b=" ) '((:unknown "a")(:definition) (:unknown "b") (:definition)))))

(test lex-definition-separator
  (is-true (equal (lex "|" ) '((:definition-separator))))
  (is-true (equal (lex "||" ) '((:definition-separator)(:definition-separator))))
  (is-true (equal (lex "a | b" ) '((:unknown "a")(:definition-separator) (:unknown "b"))))
  (is-true (equal (lex "a | b|" ) '((:unknown "a")(:definition-separator) (:unknown "b") (:definition-separator))))

  ;; / as definition-separator symbol
  (is-true (equal (lex "/" ) '((:definition-separator))))
  (is-true (equal (lex "//" ) '((:definition-separator)(:definition-separator))))
  (is-true (equal (lex "a / b" ) '((:unknown "a")(:definition-separator) (:unknown "b"))))
  (is-true (equal (lex "a / b/" ) '((:unknown "a")(:definition-separator) (:unknown "b") (:definition-separator))))

  ;; ! as definition-separator symbol
  (is-true (equal (lex "!" ) '((:definition-separator))))
  (is-true (equal (lex "!!" ) '((:definition-separator)(:definition-separator))))
  (is-true (equal (lex "a ! b" ) '((:unknown "a")(:definition-separator) (:unknown "b"))))
  (is-true (equal (lex "a ! b!" ) '((:unknown "a")(:definition-separator) (:unknown "b") (:definition-separator)))))

(test lex-concatenate
  (is-true (equal (lex "," ) '((:concatenate))))
  (is-true (equal (lex ",," ) '((:concatenate)(:concatenate))))
  (is-true (equal (lex "a , b" ) '((:unknown "a")(:concatenate) (:unknown "b"))))
  (is-true (equal (lex "a , b," ) '((:unknown "a")(:concatenate) (:unknown "b") (:concatenate)))))

(test lex-exception
  (is-true (equal (lex "-" ) '((:exception))))
  (is-true (equal (lex "--" ) '((:exception)(:exception))))
  (is-true (equal (lex "a - b" ) '((:unknown "a")(:exception) (:unknown "b"))))
  (is-true (equal (lex "a - b-" ) '((:unknown "a")(:exception) (:unknown "b") (:exception)))))

(test lex-repetition
  (is-true (equal (lex "*" ) '((:repetition))))
  (is-true (equal (lex "**" ) '((:repetition)(:repetition))))
  (is-true (equal (lex "a * b" ) '((:unknown "a")(:repetition) (:unknown "b"))))
  (is-true (equal (lex "a * b*" ) '((:unknown "a")(:repetition) (:unknown "b") (:repetition)))))

(test lex-terminator
  (is-true (equal (lex "." ) '((:terminator))))
  (is-true (equal (lex ".." ) '((:terminator)(:terminator))))
  (is-true (equal (lex "a . b" ) '((:unknown "a")(:terminator) (:unknown "b"))))
  (is-true (equal (lex "a . b." ) '((:unknown "a")(:terminator) (:unknown "b") (:terminator))))

  ;; ";" as terminator symbol
  (is-true (equal (lex ";" ) '((:terminator))))
  (is-true (equal (lex ";;" ) '((:terminator)(:terminator))))
  (is-true (equal (lex "a ; b" ) '((:unknown "a")(:terminator) (:unknown "b"))))
  (is-true (equal (lex "a ; b;" ) '((:unknown "a")(:terminator) (:unknown "b") (:terminator)))))

(test lex-special-sequence
  (is-true (equal (lex "??") '((:special-sequence nil))))
  (is-true (equal (lex "?  ?") '((:special-sequence nil))))
  (is-true (equal (lex "   ??") '((:special-sequence nil))))
  (is-true (equal (lex "??   ") '((:special-sequence nil))))
  (is-true (equal (lex "  ?  ?  ") '((:special-sequence nil))))
  (is-true (equal (lex "?ab?") '((:special-sequence ((:unknown "ab"))))))
  (is-true (equal (lex "?ab cd?") '((:special-sequence ((:unknown "ab") (:unknown "cd"))))))
  (signals malformed-token (lex "?"))
  (signals malformed-token (lex "?ab"))
  (signals malformed-token (lex "?ab? cd ?"))
  (signals malformed-token (lex "ab?")))

(test lex-quoted-symbol
  (is-true (equal (lex "\"\"") '((:quoted-symbol ""))))
  (is-true (equal (lex "\"asd\"") '((:quoted-symbol "asd"))))
  (is-true (equal (lex "\"asd bcg\"") '((:quoted-symbol "asd bcg"))))
  (is-true (equal (lex "\"   asd bcg\"") '((:quoted-symbol "   asd bcg"))))
  (is-true (equal (lex "\"asd bcg   \"") '((:quoted-symbol "asd bcg   "))))
  (signals malformed-token (lex "\"asd\\\"bcg\"")) ; no escaped quote allowed
  (signals malformed-token (lex "\"\\\"\"")) ; no escaped quote allowed
  (signals malformed-token (lex "\""))
  (signals malformed-token (lex "asd\""))
  (signals malformed-token (lex "\"asd\" bcg \""))

  ;; ' as quoted-symbol
  (is-true (equal (lex "''") '((:quoted-symbol ""))))
  (is-true (equal (lex "'asd'") '((:quoted-symbol "asd"))))
  (is-true (equal (lex "'asd bcg'") '((:quoted-symbol "asd bcg"))))
  (is-true (equal (lex "'   asd bcg'") '((:quoted-symbol "   asd bcg"))))
  (is-true (equal (lex "'asd bcg   '") '((:quoted-symbol "asd bcg   "))))
  (is-true (equal (lex "'\\'") '((:quoted-symbol "\\"))))
  (signals malformed-token (lex "'asd\\'bcg'")) ; no escaped quote allowed
  (signals malformed-token (lex "'\\''")) ; no escaped quote allowed
  (signals malformed-token (lex "'"))
  (signals malformed-token (lex "asd'"))
  (signals malformed-token (lex "'asd' bcg '")))

(test lex-mixed
  (is-true (equal (lex "Fortran 77 continuation line = 5 * \" \", (character - (\" \" | \"0\")), 66 * [character] ;")
		  '((:unknown "Fortran") (:unknown "77") (:unknown "continuation")
		    (:unknown "line") (:definition) (:unknown "5") (:repetition)
		    (:quoted-symbol " ") (:concatenate)
		    (:group
		     ((:unknown "character") (:exception)
		      (:group
		       ((:quoted-symbol " ") (:definition-separator) (:quoted-symbol "0")))))
		    (:concatenate) (:unknown "66") (:repetition)
		    (:option ((:unknown "character"))) (:terminator))))

  (is-true (equal (lex "Fortran 77 continuation line = character - \"C\", 4 * character, (character - (\" \" | \"0\")), 66 * [character] ;")
		  '((:unknown "Fortran") (:unknown "77") (:unknown "continuation")
		    (:unknown "line") (:definition) (:unknown "character") (:exception) (:quoted-symbol "C") (:concatenate)
		    (:unknown "4") (:repetition) (:unknown "character") (:concatenate)
		    (:group
		     ((:unknown "character") (:exception)
		      (:group
		       ((:quoted-symbol " ") (:definition-separator) (:quoted-symbol "0")))))
		    (:concatenate) (:unknown "66") (:repetition)
		    (:option ((:unknown "character"))) (:terminator)))))

(test lex-letter
  (is-true (equal (lex (concatenate 'string
				    "letter" " " "="
				    "'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm'"
				    " | "
				    "'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z'"
				    " | "
				    "'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H' | 'I' | 'J' | 'K' | 'L' | 'M'"
				    " | "
				    "'N' | 'O' | 'P' | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z'"
				    ))
		  '((:unknown "letter") (:definition)
		    (:quoted-symbol "a") (:definition-separator) (:quoted-symbol "b") (:definition-separator) (:quoted-symbol "c")
		    (:definition-separator) (:quoted-symbol "d") (:definition-separator) (:quoted-symbol "e") (:definition-separator)
		    (:quoted-symbol "f") (:definition-separator) (:quoted-symbol "g") (:definition-separator) (:quoted-symbol "h")
		    (:definition-separator) (:quoted-symbol "i") (:definition-separator) (:quoted-symbol "j") (:definition-separator)
		    (:quoted-symbol "k") (:definition-separator) (:quoted-symbol "l") (:definition-separator) (:quoted-symbol "m")
		    (:definition-separator) (:quoted-symbol "n") (:definition-separator) (:quoted-symbol "o") (:definition-separator)
		    (:quoted-symbol "p") (:definition-separator) (:quoted-symbol "q") (:definition-separator) (:quoted-symbol "r")
		    (:definition-separator) (:quoted-symbol "s") (:definition-separator) (:quoted-symbol "t") (:definition-separator)
		    (:quoted-symbol "u") (:definition-separator) (:quoted-symbol "v") (:definition-separator) (:quoted-symbol "w")
		    (:definition-separator) (:quoted-symbol "x") (:definition-separator) (:quoted-symbol "y") (:definition-separator)
		    (:quoted-symbol "z") (:definition-separator)
		    (:quoted-symbol "A") (:definition-separator) (:quoted-symbol "B") (:definition-separator) (:quoted-symbol "C")
		    (:definition-separator) (:quoted-symbol "D") (:definition-separator) (:quoted-symbol "E") (:definition-separator)
		    (:quoted-symbol "F") (:definition-separator) (:quoted-symbol "G") (:definition-separator) (:quoted-symbol "H")
		    (:definition-separator) (:quoted-symbol "I") (:definition-separator) (:quoted-symbol "J") (:definition-separator)
		    (:quoted-symbol "K") (:definition-separator) (:quoted-symbol "L") (:definition-separator) (:quoted-symbol "M")
		    (:definition-separator) (:quoted-symbol "N") (:definition-separator) (:quoted-symbol "O") (:definition-separator)
		    (:quoted-symbol "P") (:definition-separator) (:quoted-symbol "Q") (:definition-separator) (:quoted-symbol "R")
		    (:definition-separator) (:quoted-symbol "S") (:definition-separator) (:quoted-symbol "T") (:definition-separator)
		    (:quoted-symbol "U") (:definition-separator) (:quoted-symbol "V") (:definition-separator) (:quoted-symbol "W")
		    (:definition-separator) (:quoted-symbol "X") (:definition-separator) (:quoted-symbol "Y") (:definition-separator)
		    (:quoted-symbol "Z")))))

(test lex-decimal-digit
  (is-true (equal (lex "decimal digit = '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'")
		  '((:unknown "decimal") (:unknown "digit") (:definition) (:quoted-symbol "0") (:definition-separator) (:quoted-symbol "1")
		    (:definition-separator) (:quoted-symbol "2") (:definition-separator) (:quoted-symbol "3") (:definition-separator)
		    (:quoted-symbol "4") (:definition-separator) (:quoted-symbol "5") (:definition-separator) (:quoted-symbol "6")
		    (:definition-separator) (:quoted-symbol "7") (:definition-separator) (:quoted-symbol "8") (:definition-separator)
		    (:quoted-symbol "9")))))

(test lex-concatenate-symbol
  (is-true (equal (lex "concatenate symbol = ',';")
		  '((:unknown "concatenate") (:unknown "symbol") (:definition) (:quoted-symbol ",") (:terminator)))))

(test lex-defining-symbol
  (is-true (equal (lex "defining symbol = '=';")
		  '((:unknown "defining") (:unknown "symbol") (:definition) (:quoted-symbol "=") (:terminator)))))

(test lex-definition-separator-symbol
  (is-true (equal (lex "definition separator symbol = '|' | '/' | '!';")
		  '((:unknown "definition") (:unknown "separator") (:unknown "symbol")
		    (:definition)
		    (:quoted-symbol "|") (:definition-separator) (:quoted-symbol "/") (:definition-separator) (:quoted-symbol "!")
		    (:terminator)))))

(test lex-start-comment-symbol
  (is-true (equal (lex "start comment symbol = '(*';")
		  '((:unknown "start") (:unknown "comment") (:unknown "symbol") (:definition) (:quoted-symbol "(*") (:terminator)))))

(test lex-end-comment-symbol
  (is-true (equal (lex "end comment symbol = '*)';")
		  '((:unknown "end") (:unknown "comment") (:unknown "symbol") (:definition) (:quoted-symbol "*)") (:terminator)))))

(test lex-start-group-symbol
  (is-true (equal (lex "start group symbol = '(';")
		  '((:unknown "start") (:unknown "group") (:unknown "symbol") (:definition) (:quoted-symbol "(") (:terminator)))))

(test lex-end-group-symbol
  (is-true (equal (lex "end group symbol = ')';")
		  '((:unknown "end") (:unknown "group") (:unknown "symbol") (:definition) (:quoted-symbol ")") (:terminator)))))

(test lex-start-option-symbol
  (is-true (equal (lex "start option symbol = '[' | '(/';")
		  '((:unknown "start") (:unknown "option") (:unknown "symbol")
		    (:definition)
		    (:quoted-symbol "[") (:definition-separator) (:quoted-symbol "(/") (:terminator)))))

(test lex-end-option-symbol
  (is-true (equal (lex "end option symbol = ']' | '/)';")
		  '((:unknown "end") (:unknown "option") (:unknown "symbol")
		    (:definition)
		    (:quoted-symbol "]") (:definition-separator) (:quoted-symbol "/)") (:terminator)))))

(test lex-start-repeat-symbol
  (is-true (equal (lex "start repeat symbol = '{' | '(:';")
		  '((:unknown "start") (:unknown "repeat") (:unknown "symbol")
		    (:definition)
		    (:quoted-symbol "{") (:definition-separator) (:quoted-symbol "(:") (:terminator)))))

(test lex-end-repeat-symbol
  (is-true (equal (lex "end repeat symbol = '}' | ':)';")
		  '((:unknown "end") (:unknown "repeat") (:unknown "symbol")
		    (:definition)
		    (:quoted-symbol "}") (:definition-separator) (:quoted-symbol ":)") (:terminator)))))

(test lex-except-symbol
  (is-true (equal (lex "except symbol = '-';")
		  '((:unknown "except") (:unknown "symbol") (:definition) (:quoted-symbol "-") (:terminator)))))

(test lex-first-quote-symbol
  (is-true (equal (lex "first quote symbol = \"'\";")
		  '((:unknown "first") (:unknown "quote") (:unknown "symbol") (:definition) (:quoted-symbol "'") (:terminator)))))

(test lex-second-quote-symbol
  (is-true (equal (lex "second quote symbol = '\"';")
		  '((:unknown "second") (:unknown "quote") (:unknown "symbol") (:definition) (:quoted-symbol "\"") (:terminator)))))

(test lex-repetition-symbol
  (is-true (equal (lex "repetition symbol = '*';")
		  '((:unknown "repetition") (:unknown "symbol") (:definition) (:quoted-symbol "*") (:terminator)))))

(test lex-special-sequence-symbol
  (is-true (equal (lex "special sequence symbol = '?';")
		  '((:unknown "special") (:unknown "sequence") (:unknown "symbol") (:definition) (:quoted-symbol "?") (:terminator)))))

(test lex-terminator-symbol
  (is-true (equal (lex "terminator symbol = ';' | '.';")
		  '((:unknown "terminator") (:unknown "symbol")
		    (:definition)
		    (:quoted-symbol ";") (:definition-separator) (:quoted-symbol ".") (:terminator)))))

(test lex-other-character
  (is-true (equal (lex "other character = ' ' | ':' | '+' | '_' | '%' | '@' | '&' | '#' | '$' | '<' | '>' | '^' | '`' | '\\' | '~';")
		  '((:unknown "other") (:unknown "character") (:definition) (:quoted-symbol " ") (:definition-separator) (:quoted-symbol ":")
		    (:definition-separator) (:quoted-symbol "+") (:definition-separator) (:quoted-symbol "_") (:definition-separator)
		    (:quoted-symbol "%") (:definition-separator) (:quoted-symbol "@") (:definition-separator) (:quoted-symbol "&")
		    (:definition-separator) (:quoted-symbol "#") (:definition-separator) (:quoted-symbol "$") (:definition-separator)
		    (:quoted-symbol "<") (:definition-separator) (:quoted-symbol ">") (:definition-separator) (:quoted-symbol "^")
		    (:definition-separator) (:quoted-symbol "`") (:definition-separator) (:quoted-symbol "\\") (:definition-separator)
		    (:quoted-symbol "~")
		    (:terminator)))))

(test lex-space-character
  (is-true (equal (lex "space character = ' ';")
		  '((:unknown "space") (:unknown "character")
		    (:definition)
		    (:quoted-symbol " ")
		    (:terminator)))))

(test lex-horizontal-tabulation
  (is-true (equal (lex "horizontal tabulation character = ? ISO 6429 character Horizontal Tabulation ? ;")
		  '((:unknown "horizontal") (:unknown "tabulation") (:unknown "character")
		    (:definition)
		    (:special-sequence ((:unknown "ISO") (:unknown "6429") (:unknown "character")
					(:unknown "Horizontal") (:unknown "Tabulation")))
		    (:terminator)))))

(test lex-newline
  (is-true (equal
	    (lex
	     "new line = { ? ISO 6429 character Carriage Return ? }, ? ISO 6429 character Line Feed ?, { ? ISO 6429 character Carriage Return ? } ;")
	    '((:unknown "new") (:unknown "line")
	      (:definition)
	      (:repeat ((:special-sequence ((:unknown "ISO") (:unknown "6429") (:unknown "character")
					    (:unknown "Carriage") (:unknown "Return")))))
	      (:concatenate)
	      (:special-sequence ((:unknown "ISO") (:unknown "6429") (:unknown "character")
				  (:unknown "Line") (:unknown "Feed")))
	      (:concatenate)
	      (:repeat ((:special-sequence ((:unknown "ISO") (:unknown "6429") (:unknown "character")
					    (:unknown "Carriage") (:unknown "Return")))))
	      (:terminator)))))

(test lex-vertical-tabulation
  (is-true (equal (lex "vertical tabulation character = ? ISO 6429 character Vertical Tabulation ? ;")
		  '((:unknown "vertical") (:unknown "tabulation") (:unknown "character")
		    (:definition)
		    (:special-sequence ((:unknown "ISO") (:unknown "6429") (:unknown "character")
					(:unknown "Vertical") (:unknown "Tabulation")))
		    (:terminator)))))

(test lex-formfeed
  (is-true (equal (lex "form feed = ? ISO 6429 character Form Feed ? ;")
		  '((:unknown "form") (:unknown "feed")
		    (:definition)
		    (:special-sequence ((:unknown "ISO") (:unknown "6429") (:unknown "character")
					(:unknown "Form") (:unknown "Feed")))
		    (:terminator)))))

(test lex-terminal-character
  (is (equal (lex (concatenate 'string
				    "terminal character"
				    " = "
				    "letter"
				    " | decimal digit"
				    " | concatenate symbol"
				    " | defining symbol"
				    " | definition separator symbol"
				    " | start comment symbol"
				    " | end comment symbol"
				    " | start group symbol"
				    " | end group symbol"
				    " | start option symbol"
				    " | end option symbol"
				    " | start repeat symbol"
				    " | end repeat symbol"
				    " | except symbol"
				    " | first quote symbol"
				    " | second quote symbol"
				    " | repetition symbol"
				    " | special sequence symbol"
				    " | terminator symbol"
				    " | other character"
				    " ;"
				    ))
		  '((:unknown "terminal") (:unknown "character")
		    (:definition)
		    (:unknown "letter")
		    (:definition-separator) (:unknown "decimal") (:unknown "digit")
		    (:definition-separator) (:unknown "concatenate") (:unknown "symbol")
		    (:definition-separator) (:unknown "defining") (:unknown "symbol")
		    (:definition-separator) (:unknown "definition") (:unknown "separator") (:unknown "symbol")
		    (:definition-separator) (:unknown "start") (:unknown "comment") (:unknown "symbol")
		    (:definition-separator) (:unknown "end") (:unknown "comment") (:unknown "symbol")
		    (:definition-separator) (:unknown "start") (:unknown "group") (:unknown "symbol")
		    (:definition-separator) (:unknown "end") (:unknown "group") (:unknown "symbol")
		    (:definition-separator) (:unknown "start") (:unknown "option") (:unknown "symbol")
		    (:definition-separator) (:unknown "end") (:unknown "option") (:unknown "symbol")
		    (:definition-separator) (:unknown "start") (:unknown "repeat") (:unknown "symbol")
		    (:definition-separator) (:unknown "end") (:unknown "repeat") (:unknown "symbol")
		    (:definition-separator) (:unknown "except") (:unknown "symbol")
		    (:definition-separator) (:unknown "first") (:unknown "quote") (:unknown "symbol")
		    (:definition-separator) (:unknown "second") (:unknown "quote") (:unknown "symbol")
		    (:definition-separator) (:unknown "repetition") (:unknown "symbol")
		    (:definition-separator) (:unknown "special") (:unknown "sequence") (:unknown "symbol")
		    (:definition-separator) (:unknown "terminator") (:unknown "symbol")
		    (:definition-separator) (:unknown "other") (:unknown "character")
		    (:terminator)))))

(test lex-gap-free-symbol
  (is-true (equal (lex "gap free symbol = terminal character - (first quote symbol | second quote symbol) | terminal string ;")
		  '((:unknown "gap") (:unknown "free") (:unknown "symbol")
		    (:definition)
		    (:unknown "terminal") (:unknown "character")
		    (:exception)
		    (:group ((:unknown "first") (:unknown "quote") (:unknown "symbol")
			     (:definition-separator)
			     (:unknown "second") (:unknown "quote") (:unknown "symbol")))
		    (:definition-separator)
		    (:unknown "terminal") (:unknown "string")
		    (:terminator)))))

(test lex-terminal-string
  (is-true (equal (lex (concatenate 'string
				    "terminal string"
				    " = "
				    "first quote symbol, first quote character, {first quote character}, first quote symbol"
				    " | "
				    "second quote symbol, second quote character, {second quote character}, second quote symbol"
				    " ;"))
		  '((:unknown "terminal") (:unknown "string")
		    (:definition)
		    (:unknown "first") (:unknown "quote")(:unknown "symbol")
		    (:concatenate)
		    (:unknown "first") (:unknown "quote") (:unknown "character")
		    (:concatenate)
		    (:repeat ((:unknown "first") (:unknown "quote") (:unknown "character")))
		    (:concatenate)
		    (:unknown "first") (:unknown "quote") (:unknown "symbol")
		    (:definition-separator)
		    (:unknown "second") (:unknown "quote")(:unknown "symbol")
		    (:concatenate)
		    (:unknown "second") (:unknown "quote") (:unknown "character")
		    (:concatenate)
		    (:repeat ((:unknown "second") (:unknown "quote") (:unknown "character")))
		    (:concatenate)
		    (:unknown "second") (:unknown "quote") (:unknown "symbol")
		    (:terminator)))))

(test lex-first-terminal-character
  (is-true (equal (lex "first terminal character = terminal character - first quote symbol ;")
		  '((:unknown "first") (:unknown "terminal") (:unknown "character")
		    (:definition)
		    (:unknown "terminal") (:unknown "character")
		    (:exception)
		    (:unknown "first") (:unknown "quote") (:unknown "symbol")
		    (:terminator)))))

(test lex-second-terminal-character
  (is-true (equal (lex "second terminal character = terminal character - second quote symbol ;")
		  '((:unknown "second") (:unknown "terminal") (:unknown "character")
		    (:definition)
		    (:unknown "terminal") (:unknown "character")
		    (:exception)
		    (:unknown "second") (:unknown "quote") (:unknown "symbol")
		    (:terminator)))))

(test lex-gap-separator
  (is-true
   (equal (Lex "gap separator = space character | horizontal tabulation character | new line | vertical tabulation character | form feed;")
	  '((:unknown "gap") (:unknown "separator")
	    (:definition)
	    (:unknown "space") (:unknown "character")
	    (:definition-separator)
	    (:unknown "horizontal") (:unknown "tabulation") (:unknown "character")
	    (:definition-separator)
	    (:unknown "new") (:unknown "line")
	    (:definition-separator)
	    (:unknown "vertical") (:unknown "tabulation") (:unknown "character")
	    (:definition-separator)
	    (:unknown "form") (:unknown "feed")
	    (:terminator)))))

(test lex-commentless-symbol
  (is-true
   (equal (lex (concatenate
		'string
		"commentless symbol"
		" = "
		"terminal character"
		" - "
		"( "
		"  letter | decimal digit | first quote symbol | second quote symbol | start comment symbol | end comment symbol"
		"| special sequence symbol | other character"
		" )"
		"| meta identifier | integer | terminal string | special sequence"
		" ;"))
	  '((:unknown "commentless") (:unknown "symbol")
	    (:definition)
	    (:unknown "terminal") (:unknown "character")
	    (:exception)
	    (:group ((:unknown "letter")
		     (:definition-separator)
		     (:unknown "decimal") (:unknown "digit")
		     (:definition-separator)
		     (:unknown "first") (:unknown "quote") (:unknown "symbol")
		     (:definition-separator)
		     (:unknown "second") (:unknown "quote") (:unknown "symbol")
		     (:definition-separator)
		     (:unknown "start") (:unknown "comment") (:unknown "symbol")
		     (:definition-separator)
		     (:unknown "end") (:unknown "comment") (:unknown "symbol")
		     (:definition-separator)
		     (:unknown "special") (:unknown "sequence") (:unknown "symbol")
		     (:definition-separator)
		     (:unknown "other") (:unknown "character")))
	    (:definition-separator)
	    (:unknown "meta") (:unknown "identifier")
	    (:definition-separator)
	    (:unknown "integer")
	    (:definition-separator)
	    (:unknown "terminal") (:unknown "string")
	    (:definition-separator)
	    (:unknown "special") (:unknown "sequence")
	    (:terminator)))))

(test lex-integer
  (is-true (equal (lex "integer = decimal digit, {decimal digit} ;")
		  '((:unknown "integer")
		    (:definition)
		    (:unknown "decimal") (:unknown "digit")
		    (:concatenate)
		    (:repeat ((:unknown "decimal") (:unknown "digit")))
		    (:terminator)))))

(test lex-meta-identifier
  (is-true (equal (lex "meta identifier = letter, { meta identifier character } ;")
		  '((:unknown "meta") (:unknown "identifier")
		    (:definition)
		    (:unknown "letter")
		    (:concatenate)
		    (:repeat ((:unknown "meta") (:unknown "identifier") (:unknown "character")))
		    (:terminator)))))

(test lex-meta-identifier-character
  (is-true (equal (lex "meta identifier character = letter | decimal digit ;")
		  '((:unknown "meta") (:unknown "identifier") (:unknown "character")
		    (:definition)
		    (:unknown "letter")
		    (:definition-separator)
		    (:unknown "decimal") (:unknown "digit")
		    (:terminator)))))

(test lex-special-sequence
  (is-true (equal (lex "special sequence = special sequence symbol, { special sequence character }, special sequence symbol ;")
		  '((:unknown "special") (:unknown "sequence")
		    (:definition)
		    (:unknown "special") (:unknown "sequence") (:unknown "symbol")
		    (:concatenate)
		    (:repeat ((:unknown "special") (:unknown "sequence") (:unknown "character")))
		    (:concatenate)
		    (:unknown "special") (:unknown "sequence") (:unknown "symbol")
		    (:terminator)))))

(test lex-special-sequence-character
  (is-true (equal (lex "special sequence character = terminal character - special sequence symbol ;")
		  '((:unknown "special") (:unknown "sequence") (:unknown "character")
		    (:definition)
		    (:unknown "terminal") (:unknown "character")
		    (:exception)
		    (:unknown "special") (:unknown "sequence") (:unknown "symbol")
		    (:terminator)))))

(test lex-comment-symbol
  (is-true (equal (lex "comment symbol = bracketed textual comment | other character | commentless symbol ;")
		  '((:unknown "comment") (:unknown "symbol")
		    (:definition)
		    (:unknown "bracketed") (:unknown "textual") (:unknown "comment")
		    (:definition-separator)
		    (:unknown "other") (:unknown "character")
		    (:definition-separator)
		    (:unknown "commentless") (:unknown "symbol")
		    (:terminator)))))

(test lex-bracketed-textual-comment
  (is-true (equal (lex "bracketed textual comment = start comment symbol, { comment symbol }, end comment symbol ;")
		  '((:unknown "bracketed") (:unknown "textual") (:unknown "comment")
		    (:definition)
		    (:unknown "start") (:unknown "comment") (:unknown "symbol")
		    (:concatenate)
		    (:repeat ((:unknown "comment") (:unknown "symbol")))
		    (:concatenate)
		    (:unknown "end") (:unknown "comment") (:unknown "symbol")
		    (:terminator)))))
