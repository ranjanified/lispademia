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
		    (:option ((:unknown "character"))) (:terminator)))))
