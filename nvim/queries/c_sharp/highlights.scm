;; extends

((member_access_expression 
  expression: (identifier)) @type
  (#lua-match? @type "^[A-Z].*"))