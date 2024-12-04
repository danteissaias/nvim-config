return {
  "Saghen/blink.cmp",
  event = "InsertEnter",
  build = "cargo +nightly build --release",
  opts = {
    keymap = {
      preset = "enter",
    },
    sources = {
      -- add lazydev to your completion providers
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
      },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
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
