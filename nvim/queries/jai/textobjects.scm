(parameter (identifier) ":" "="? (identifier)? ","?) @parameter.inner 

argument: (_) @parameter.inner

(assignment_parameters
  "," @_start
  .
  (_) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))

(assignment_parameters
.
(_) @parameter.inner
.
","? @_end
(#make-range! "parameter.outer" @parameter.inner @_end))

(named_parameters
  "," @_start
  .
  (_) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))

(named_parameters
.
(_) @parameter.inner
.
","? @_end
(#make-range! "parameter.outer" @parameter.inner @_end))