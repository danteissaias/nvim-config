return {
  "catppuccin/nvim",
  name = "catppuccin",
  -- Old version because I don't like https://github.com/catppuccin/nvim/pull/804
  version = "1.11.0",
  opts = {
    integrations = {
      blink_cmp = true,
      fzf = true,
      treesitter = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme "catppuccin"
  end,
}
