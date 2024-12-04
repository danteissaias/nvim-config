return {
  "Saghen/blink.cmp",
  event = "InsertEnter",
  build = "cargo +nightly build --release",
  opts = {
    nerd_font_variant = "mono",
    keymap = {
      preset = "enter",
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
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
  },
}
