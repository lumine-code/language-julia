; Block keywords and delimiters remain local to the current row.
(["module" "baremodule" "struct" "macro" "function" "begin" "if" "try" "for" "while" "let" "quote" "do"] @indent
  (#is? test.childOfType "module_definition struct_definition macro_definition function_definition compound_statement if_statement try_statement for_statement while_statement let_statement quote_statement do_clause"))
["(" "[" "{"] @indent
["end" ")" "]" "}"] @dedent
["else" "elseif" "catch" "finally"] @dedent @indent
