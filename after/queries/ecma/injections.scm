; extends

; Use the language name in /* lua */, /* html */, etc. before a template string.
((comment) @injection.language
  .
  [
    (template_string) @injection.content
    (expression_statement
      (template_string) @injection.content)
  ]
  (#lua-match? @injection.language "^/%*%s*[%w_]+%s*%*/$")
  (#gsub! @injection.language "^/%*%s*([%w_]+)%s*%*/$" "%1")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))
