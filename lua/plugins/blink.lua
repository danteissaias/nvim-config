return {
  "Saghen/blink.cmp",
  build = "nix run .#build-plugin",
  event = "InsertEnter",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
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
      default = { "lsp", "path", "snippets", "lazydev" },
      providers = {
        lsp = { fallbacks = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- Extend neovim's client capabilities with the completion ones.
    vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
  end,
}
