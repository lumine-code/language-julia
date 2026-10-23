; Content captures leave Julia interpolation out of each literal's layer.
((string_literal (content) @injection.content) @injection.owner
  . [(abstract_definition) (assignment) (const_statement) (function_definition)
     (macro_definition) (module_definition) (struct_definition)]
  (#set! injection.language "markdown"))
((source_file
   (string_literal (content) @injection.content) @injection.owner
   . [(identifier) (call_expression)])
  (#set! injection.language "markdown"))
((prefixed_string_literal prefix: (identifier) @_prefix
   (content) @injection.content) @injection.owner
  (#eq? @_prefix "r")
  (#set! injection.language "regex"))
((prefixed_string_literal prefix: (identifier) @_prefix
   (content) @injection.content) @injection.owner
  (#eq? @_prefix "md")
  (#set! injection.language "markdown"))
((command_literal (content) @injection.content) @injection.owner
  (#set! injection.language "bash"))

([
  (line_comment)
  (block_comment)
] @injection.owner @injection.content
  (#set! injection.language "hyperlink")
  (#set! injection.language-scope "none")
  (#set! injection.include-children))
([
  (line_comment)
  (block_comment)
] @injection.owner @injection.content
  (#set! injection.language "todo")
  (#set! injection.language-scope "none")
  (#set! injection.include-children))
