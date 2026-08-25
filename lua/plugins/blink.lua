return {
  src = "Saghen/blink.cmp",
  dependencies = {
    { src = "Saghen/blink.lib" },
  },
  build = function()
    -- On updates, blink.cmp may already be loaded with the old git commit.
    -- Reload it so the native fuzzy lib is built for the new commit hash.
    package.loaded["blink.cmp"] = nil
    require("blink.cmp").build():pwait(60000)
  end,
  config = function()
    require("blink.cmp").setup {
      appearance = { nerd_font_variant = "mono" },
      completion = {
        trigger = {
          prefetch_on_insert = false,
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
