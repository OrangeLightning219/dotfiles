((directive
   block: (jai_block) @injection.content)
 (#set! injection.language "jai")
 (#set! injection.include-children))

((hlsl_section
   (hlsl_body) @injection.content)
 (#set! injection.language "hlsl")) 