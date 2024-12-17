---@diagnostic disable: missing-fields

return {
  "Saghen/blink.cmp",
  lazy = false,
  build = "cargo build --release",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    appearance = { nerd_font_variant = "mono" },
    completion = {
      -- trigger = {
      --   prefetch_on_insert = true,
      -- },
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
      cmdline = {},
      providers = {
        lsp = { fallbacks = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
  },
}
