return {
  "Saghen/blink.cmp",
  lazy = false,
  build = "cargo +nightly build --release",
  opts = {
    appearance = { nerd_font_variant = "mono" },
    completion = {
      trigger = {
        prefetch = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 0,
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      cmdline = {},
      providers = {
        lsp = { fallback = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
  },
}
