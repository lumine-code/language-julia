; Identifiers
(identifier) @variable.other.julia

(field_expression
  (identifier) @variable.other.member.julia .)

; Symbols
(quote_expression
  ":" @constant.other.symbol.julia
  [
    (identifier)
    (operator)
  ] @constant.other.symbol.julia)

; Function calls
(call_expression
  (identifier) @support.other.function.julia)

(call_expression
  (field_expression
    (identifier) @support.other.function.julia .))

(broadcast_call_expression
  (identifier) @support.other.function.julia)

(broadcast_call_expression
  (field_expression
    (identifier) @support.other.function.julia .))

(binary_expression
  (_)
  (operator) @_IGNORE_.pipe
  (identifier) @support.other.function.julia
  (#any-of? @_IGNORE_.pipe "|>" ".|>"))

; Macros
(macro_identifier
  "@" @entity.name.function.macro.julia
  (identifier) @entity.name.function.macro.julia)

(macro_definition
  (signature
    (call_expression
      .
      (identifier) @entity.name.function.macro.julia)))

; Built-in functions
; print.("\"", filter(name -> getglobal(Core, name) isa Core.Builtin, names(Core)), "\" ")
((identifier) @support.function.builtin.julia
  (#any-of? @support.function.builtin.julia
    "applicable" "fieldtype" "getfield" "getglobal" "invoke" "isa" "isdefined" "isdefinedglobal"
    "modifyfield!" "modifyglobal!" "nfields" "replacefield!" "replaceglobal!" "setfield!"
    "setfieldonce!" "setglobal!" "setglobalonce!" "swapfield!" "swapglobal!" "throw" "tuple"
    "typeassert" "typeof"))

; Type definitions
(type_head
  (_) @entity.name.type.julia)

; Type annotations
(parametrized_type_expression
  [
    (identifier) @support.type.julia
    (field_expression
      (identifier) @support.type.julia .)
  ]
  (curly_expression
    (_) @support.type.julia))

(typed_expression
  (identifier) @support.type.julia .)

(unary_typed_expression
  (identifier) @support.type.julia .)

(where_expression
  [
    (curly_expression
      (_) @support.type.julia)
    (_) @support.type.julia
  ] .)

(unary_expression
  (operator) @keyword.operator.julia
  (_) @support.type.julia
  (#any-of? @keyword.operator.julia "<:" ">:"))

(binary_expression
  (_) @support.type.julia
  (operator) @keyword.operator.julia
  (_) @support.type.julia
  (#any-of? @keyword.operator.julia "<:" ">:"))

; Built-in types
; print.("\"", filter(name -> typeof(Base.eval(Core, name)) in [DataType, UnionAll], names(Core)), "\" ")
((identifier) @support.type.builtin.julia
  (#any-of? @support.type.builtin.julia
    "AbstractArray" "AbstractChar" "AbstractFloat" "AbstractString" "Any" "ArgumentError" "Array"
    "AssertionError" "AtomicMemory" "AtomicMemoryRef" "Bool" "BoundsError" "Char"
    "ConcurrencyViolationError" "Cvoid" "DataType" "DenseArray" "DivideError" "DomainError"
    "ErrorException" "Exception" "Expr" "FieldError" "Float16" "Float32" "Float64" "Function"
    "GenericMemory" "GenericMemoryRef" "GlobalRef" "IO" "InexactError" "InitError" "Int" "Int128"
    "Int16" "Int32" "Int64" "Int8" "Integer" "InterruptException" "LineNumberNode" "LoadError"
    "Memory" "MemoryRef" "Method" "MethodError" "Module" "NTuple" "NamedTuple" "Nothing" "Number"
    "OutOfMemoryError" "OverflowError" "Pair" "Ptr" "QuoteNode" "ReadOnlyMemoryError" "Real" "Ref"
    "SegmentationFault" "Signed" "StackOverflowError" "String" "Symbol" "Task" "Tuple" "Type"
    "TypeError" "TypeVar" "UInt" "UInt128" "UInt16" "UInt32" "UInt64" "UInt8" "UndefInitializer"
    "UndefKeywordError" "UndefRefError" "UndefVarError" "Union" "UnionAll" "Unsigned" "VecElement"
    "WeakRef"))

; Keywords
[
  "global"
  "local"
] @keyword.control.julia

(compound_statement
  [
    "begin"
    "end"
  ] @keyword.control.julia)

(quote_statement
  [
    "quote"
    "end"
  ] @keyword.control.julia)

(let_statement
  [
    "let"
    "end"
  ] @keyword.control.julia)

(if_statement
  [
    "if"
    "end"
  ] @keyword.control.conditional.julia)

(elseif_clause
  "elseif" @keyword.control.conditional.julia)

(else_clause
  "else" @keyword.control.conditional.julia)

(ternary_expression
  [
    "?"
    ":"
  ] @keyword.operator.ternary.julia)

(try_statement
  [
    "try"
    "end"
  ] @keyword.control.exception.julia)

(catch_clause
  "catch" @keyword.control.exception.julia)

(finally_clause
  "finally" @keyword.control.exception.julia)

(for_statement
  [
    "for"
    "end"
  ] @keyword.control.loop.julia)

(for_binding
  "outer" @keyword.control.loop.julia)

; comprehensions
(for_clause
  "for" @keyword.control.loop.julia)

(if_clause
  "if" @keyword.control.conditional.julia)

(while_statement
  [
    "while"
    "end"
  ] @keyword.control.loop.julia)

[
  (break_statement)
  (continue_statement)
] @keyword.control.loop.julia

[
  "const"
  "mutable"
] @storage.modifier.julia

(function_definition
  [
    "function"
    "end"
  ] @storage.type.function.julia)

(do_clause
  [
    "do"
    "end"
  ] @storage.type.function.julia)

(macro_definition
  [
    "macro"
    "end"
  ] @keyword.control.julia)

(return_statement
  "return" @keyword.control.return.julia)

(module_definition
  [
    "module"
    "baremodule"
    "end"
  ] @keyword.control.import.julia)

(export_statement
  "export" @keyword.control.import.julia)

(public_statement
  "public" @keyword.control.import.julia)

(import_statement
  "import" @keyword.control.import.julia)

(using_statement
  "using" @keyword.control.import.julia)

(import_alias
  "as" @keyword.control.import.julia)

(selected_import
  ":" @punctuation.separator.import.julia)

(struct_definition
  [
    "mutable"
    "struct"
    "end"
  ] @storage.type.julia)

(abstract_definition
  [
    "abstract"
    "type"
    "end"
  ] @storage.type.julia)

(primitive_definition
  [
    "primitive"
    "type"
    "end"
  ] @storage.type.julia)

; Operators & Punctuation
(operator) @keyword.operator.julia

(adjoint_expression
  "'" @keyword.operator.julia)

(range_expression
  ":" @keyword.operator.julia)

(arrow_function_expression
  "->" @keyword.operator.julia)

"." @punctuation.separator.property.julia

; `...` splats an argument list or slurps one.
"..." @keyword.operator.splat.julia

"," @punctuation.separator.comma.julia
";" @punctuation.terminator.statement.julia
"::" @punctuation.separator.type.julia

; Treat `::` as operator in type contexts, see
; https://github.com/nvim-treesitter/nvim-treesitter/pull/7392
(typed_expression
  "::" @keyword.operator.julia)

(unary_typed_expression
  "::" @keyword.operator.julia)

"(" @punctuation.definition.arguments.begin.bracket.round.julia
")" @punctuation.definition.arguments.end.bracket.round.julia
"[" @punctuation.definition.array.begin.bracket.square.julia
"]" @punctuation.definition.array.end.bracket.square.julia
"{" @punctuation.definition.type-parameters.begin.bracket.curly.julia
"}" @punctuation.definition.type-parameters.end.bracket.curly.julia

; Interpolation
(string_interpolation
  .
  "$" @punctuation.section.embedded.begin.julia)

(interpolation_expression
  .
  "$" @punctuation.section.embedded.begin.julia)

; Keyword operators
((operator) @keyword.operator.word.julia
  (#any-of? @keyword.operator.word.julia "in" "isa"))

(where_expression
  "where" @keyword.operator.word.julia)

; Built-in constants
((identifier) @constant.language.julia
  (#any-of? @constant.language.julia "nothing" "missing"))

((identifier) @variable.language.julia
  (#any-of? @variable.language.julia "begin" "end")
  (#is? test.descendantOfType "index_expression"))

; Literals
(boolean_literal) @constant.language.boolean.julia

(integer_literal) @constant.numeric.julia

(float_literal) @constant.numeric.float.julia

((identifier) @constant.numeric.float.julia
  (#any-of? @constant.numeric.float.julia "NaN" "NaN16" "NaN32" "Inf" "Inf16" "Inf32"))

(character_literal) @string.quoted.single.julia

(escape_sequence) @constant.character.escape.julia

(string_literal) @string.quoted.double.julia

(prefixed_string_literal
  prefix: (identifier) @entity.name.function.macro.julia) @string.quoted.double.julia

(command_literal) @string.other.julia

(prefixed_command_literal
  prefix: (identifier) @entity.name.function.macro.julia) @string.other.julia

((string_literal) @string.quoted.docstring.julia
  .
  [
    (abstract_definition)
    (assignment)
    (const_statement)
    (function_definition)
    (macro_definition)
    (module_definition)
    (struct_definition)
  ])

(source_file
  (string_literal) @string.quoted.docstring.julia
  .
  [
    (identifier)
    (call_expression)
  ])

[
  (line_comment)
  (block_comment)
] @comment.line.julia
