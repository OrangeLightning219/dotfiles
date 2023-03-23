; highlights.scm
[
  "if"
  "#if"
  "case"
  "return"
  "defer"
  "else"
  "for"
  "while"
  "using"
  "struct"
  "enum"
  "inline"
  "cast"

  "#import"
  "#load"
  ;"#this"
  "#insert" 
  "#type_info_none"
  "#type_info_procedures_are_void_pointers"
  "#no_padding"
  "#must"
  "#module_parameters" 
] @keyword

(null_token) @constant
(import_qualifier) @keyword
(expression_like_directive) @keyword
(assert_directive token:"#assert" @keyword)
(foreign_directive token:"#foreign" @keyword)
(deprecated_directive token:"#deprecated" @keyword)
(code_directive token:"#code" @keyword)
("#complete") @keyword
(run_statement_token) @keyword
(operator_like_directive) @keyword
(other_trailing_directive) @keyword

(file_scope_directive) @keyword
(export_scope_directive) @keyword
(module_scope_directive) @keyword

(string_literal) @string
(boolean_literal) @boolean
(here_string) @string
(number) @number
(float_literal) @number
(scientific_notation) @number
(built_in_type) @type.builtin

(named_decl name:(identifier) @function (function_definition))
(named_decl name:(identifier) @type.builtin (struct_definition))
(named_decl name:(identifier) @type.builtin (enum_definition))
(named_decl name:(identifier) @constant (const_initializer))
(named_decl name:(identifier) @text (built_in_type))
(named_decl name:(identifier) @text (unary_expression (pointer_to) @keyword (identifier) @type.builtin))

(named_decl name:(identifier) @text "=" (variable_initializer))
(named_decl name:(identifier) @text ":" (identifier) @type.builtin)

(unary_expression "." (identifier) @constant)

(named_decl name:(identifier) @text (variable_initializer))
(inline_comment) @comment
(block_comment) @comment
(func_call name:(identifier) @function)
(func_call (member_access (identifier) @text (identifier) @function))

(parameter (identifier) @constant ":")
(parameter (identifier) @constant ":" (identifier) @type.builtin)
(parameter (identifier) @constant (built_in_type) @type.builtin)
(parameter (identifier) @constant (typed_struct_literal))

(parameter (identifier) @constant (unary_expression (pointer_to) @keyword (identifier) @type.builtin))
(parameter (identifier) @constant (unary_expression (pointer_to) @keyword (built_in_type) @type.builtin))

(parameter (identifier) @constant (unary_expression (array_decl) @keyword (identifier) @type.builtin))
(parameter (identifier) @constant (unary_expression (array_decl) @keyword (unary_expression (pointer_to) @keyword (identifier) @type.builtin)))
(parameter (identifier) @constant (unary_expression (array_decl) @keyword (built_in_type) @type.builtin))
(parameter (identifier) @constant (unary_expression (array_decl) @keyword (unary_expression (pointer_to) @keyword (built_in_type) @type.builtin)))

(trailing_return_types (parameter (identifier) @function.builtin ))
(trailing_return_types (parameter (built_in_type) @function.builtin ))
(trailing_return_types (parameter (unary_expression (pointer_to) @keyword (identifier) @function.builtin )))
(trailing_return_types (parameter (identifier) @constant ":" (identifier) @function.builtin))
(trailing_return_types (parameter (identifier) @constant (built_in_type) @function.builtin))
(trailing_return_types (parameter (identifier) @constant (typed_struct_literal)))

(trailing_return_types (parameter (identifier) @constant (unary_expression (pointer_to) @keyword (identifier) @function.builtin)))
(trailing_return_types (parameter (identifier) @constant (unary_expression (pointer_to) @keyword (built_in_type) @function.builtin)))

(trailing_return_types (parameter (identifier) @constant (unary_expression (array_decl) @keyword (identifier) @function.builtin)))
(trailing_return_types (parameter (identifier) @constant (unary_expression (array_decl) @keyword (unary_expression (pointer_to) @keyword (identifier) @function.builtin))))
(trailing_return_types (parameter (identifier) @constant (unary_expression (array_decl) @keyword (built_in_type) @function.builtin)))
(trailing_return_types (parameter (identifier) @constant (unary_expression (array_decl) @keyword (unary_expression (pointer_to) @keyword (built_in_type) @function.builtin))))

(typed_struct_literal (identifier) @type.builtin)
; (for_loop name:(identifier) @variable)



[
  "-"
  "+"
  "!"
  "<<"
  "~"
  "xx"
  "xx,no_check"
  ".."
  "."
  "$"
  "="

  "=="
  "!="
  "/" 
  "*"

  ">"
  "<"
  ">="
  "<="

  ;"+="
  ;"-="
  ;"/="
  ;"*="
  ;"|="
  ;"&="
  ;"^="
  ;"%="
  ;":="

  "->"
  "::"
  ":"
  "!="
  "||"
  "&&"
  "|" 
  "&" 
  "^" 
  "%" 
] @operator

[ "(" ")" "[" "]" "{" "}" ";" "," ] @punctuation.bracket