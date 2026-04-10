return {
  src = "Saghen/blink.cmp",
  version = "v1.10.2",
  config = function()
    require("blink.cmp").setup {
      appearance = { nerd_font_variant = "mono" },
      completion = {
        trigger = {
          prefetch_on_insert = true,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 50,
          update_delay_ms = 50,
        },
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets" },
      },
    }

    vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
  end,
}
