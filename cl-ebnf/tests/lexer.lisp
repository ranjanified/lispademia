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
  (is-true (equal (lex "\"asd\\\"bcg\"") '((:quoted-symbol "asd\\\"bcg")))) ; to be checked if escaped quotes are to be preserved or not
  (is-true (equal (lex "\"\\\"\"") '((:quoted-symbol "\\\""))))
  (signals malformed-token (lex "\""))
  (signals malformed-token (lex "asd\""))
  (signals malformed-token (lex "\"asd\" bcg \""))

  ;; ' as quoted-symbol
  (is-true (equal (lex "''") '((:quoted-symbol ""))))
  (is-true (equal (lex "'asd'") '((:quoted-symbol "asd"))))
  (is-true (equal (lex "'asd bcg'") '((:quoted-symbol "asd bcg"))))
  (is-true (equal (lex "'   asd bcg'") '((:quoted-symbol "   asd bcg"))))
  (is-true (equal (lex "'asd bcg   '") '((:quoted-symbol "asd bcg   "))))
  (is-true (equal (lex "'asd\\'bcg'") '((:quoted-symbol "asd\\'bcg")))) ; to be checked if escaped quotes are to be preserved or not
  (is-true (equal (lex "'\\''") '((:quoted-symbol "\\'"))))
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

(test lex-end-comment-symbol
  (is-true (equal (lex "end comment symbol = '*)';")
		  '((:unknown "end") (:unknown "comment") (:unknown "symbol") (:definition) (:quoted-symbol "*)") (:terminator)))))

(test lex-end-group-symbol
  (is-true (equal (lex "end group symbol = ')';")
		  '((:unknown "end") (:unknown "group") (:unknown "symbol") (:definition) (:quoted-symbol ")") (:terminator)))))

(test lex-end-option-symbol
  (is-true (equal (lex "end option symbol = ']' | '/)';")
		  '((:unknown "end") (:unknown "option") (:unknown "symbol")
		    (:definition)
		    (:quoted-symbol "]") (:definition-separator) (:quoted-symbol "/)") (:terminator)))))

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
