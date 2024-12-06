return {
  "Saghen/blink.cmp",
  lazy = false,
  build = "cargo +nightly build --release",
  opts = {
    appearance = { nerd_font_variant = "mono" },
    keymap = { preset = "enter" },
    -- signature = { enabled = true },
    -- completion = { accept = { auto_brackets = { enabled = true } } },
    menu = { draw = { treesitter = true } },
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
