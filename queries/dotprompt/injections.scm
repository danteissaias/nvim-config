; The grammar keeps frontmatter and body as plain text; highlight them as the
; languages they are. Body text between Handlebars tags is one Markdown document.
((yaml_content) @injection.content
  (#set! injection.language "yaml")
  (#set! injection.include-children))

((text) @injection.content
  (#set! injection.language "markdown")
  (#set! injection.combined))
