(directive
  "#" @keyword.directive
  name: (identifier) @keyword.directive)


; The special HLSL marker.
; This assumes your grammar uses the literal "#hlsl".

(hlsl_section
  "#hlsl" @keyword.directive)