(function_statement
  name: [(identifier)] @name
  (#set! "kind" "Function")
  ) @type

(var_declaration
  (var_declarators
    (var
      name: (identifier) @name))
  (expressions
    (anon_function) @type)
  (#set! "kind" "Function")
  ) @start

(var_assignment
    (assignment_variables
      (var
        (index
          (identifier)
          (identifier) @name)))
    (expressions
      (anon_function) @type)
  (#set! "kind" "Function")
    ) @start

(function_statement
    name: (function_name) @name
  (#set! "kind" "Function")
    ) @type
