; Recovery can expose literal braces after losing a string/command wrapper.
; A surviving quote keeps Enter at the quote's existing row margin.
((ERROR ["\"" "\"\"\"" "`" "```"]) @preserve
  (#match? @preserve "^(?:=[ \\t]*)?(?:[A-Za-z_]\\w*)?(?:\"|`)")
  (#is-not? indent.matchesCurrentRow startPosition)
  (#set! indent.force true))

; Words recovered beside a literal error remain part of its open payload.
(_ (ERROR ["\"" "\"\"\"" "`" "```"]) (_) @preserve
  (#is? indent.reindent true)
  (#set! indent.force true))

(ERROR ["\"" "\"\"\"" "`" "```"] ["(" ")" "[" "]" "{" "}"] @match.next
  (#set! indent.match startPosition)
  (#set! capture.final true))
(ERROR (ERROR ["\"" "\"\"\"" "`" "```"]) ["(" ")" "[" "]" "{" "}"] @match.next
  (#set! indent.match startPosition)
  (#set! capture.final true))

(ERROR ["\"" "`"] @match.next
  (#set! indent.match startPosition))

; Preserve the exact contents of multiline literals during explicit reindent.
([(string_literal) (prefixed_string_literal) (command_literal) (prefixed_command_literal) (block_comment)] @preserve
  (#is? indent.reindent true)
  (#is-not? indent.matchesCurrentRow startPosition)
  (#set! indent.force true))

; Block keywords and delimiters remain local to the current row.
(["module" "baremodule" "struct" "macro" "function" "begin" "if" "try" "for" "while" "let" "quote" "do"] @indent
  (#is? test.childOfType "module_definition struct_definition macro_definition function_definition compound_statement if_statement try_statement for_statement while_statement let_statement quote_statement do_clause"))
["(" "[" "{"] @indent
["end" ")" "]" "}"] @dedent
["else" "elseif" "catch" "finally"] @dedent @indent
