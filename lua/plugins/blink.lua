return {
  "Saghen/blink.cmp",
  lazy = false,
  build = "cargo +nightly build --release",
  opts = {
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 0,
      },
    },
    sources = {
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
      },
      providers = {
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
  },
}
