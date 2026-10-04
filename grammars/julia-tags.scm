(module_definition name: (identifier) @name) @definition.module
[(struct_definition (type_head . (identifier) @name))
 (struct_definition (type_head . (parametrized_type_expression . (identifier) @name)))
 (struct_definition (type_head . (binary_expression . (identifier) @name)))
 (struct_definition (type_head . (binary_expression . (parametrized_type_expression . (identifier) @name))))] @definition.struct
[(abstract_definition (type_head . (identifier) @name))
 (abstract_definition (type_head . (binary_expression . (identifier) @name)))
 (primitive_definition (type_head . (identifier) @name))] @definition.type
[(function_definition (signature (call_expression . [(identifier) (field_expression) (operator)] @name)))
 (function_definition (signature (where_expression (call_expression . [(identifier) (field_expression) (operator)] @name))))
 (function_definition (signature (typed_expression (call_expression . [(identifier) (field_expression) (operator)] @name))))
 (assignment . (call_expression . [(identifier) (field_expression) (operator)] @name))] @definition.function
(macro_definition (signature (call_expression . (identifier) @name))) @definition.macro
(const_statement (assignment . (identifier) @name)) @definition.constant
(assignment . (identifier) @name
  (#is-not? test.typeAt "parent.parent const_statement")) @definition.variable
; Return annotations and where clauses do not hide a short definition.
[(assignment . (typed_expression (call_expression . [(identifier) (field_expression) (operator)] @name)))
 (assignment . (where_expression (call_expression . [(identifier) (field_expression) (operator)] @name)))
 (assignment . (where_expression (typed_expression (call_expression . [(identifier) (field_expression) (operator)] @name))))
 (function_definition (signature (where_expression (typed_expression (call_expression . [(identifier) (field_expression) (operator)] @name)))))] @definition.function
(macro_definition (signature (identifier) @name)) @definition.macro
[(abstract_definition (type_head . (parametrized_type_expression . (identifier) @name)))
 (abstract_definition (type_head . (binary_expression . (parametrized_type_expression . (identifier) @name))))
 (primitive_definition (type_head . (binary_expression . (identifier) @name)))] @definition.type
