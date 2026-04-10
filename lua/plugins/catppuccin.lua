return {
  src = "catppuccin/nvim",
  version = "v1.11.0",
  config = function()
    require("catppuccin").setup {
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
    }
    vim.cmd.colorscheme "catppuccin"
  end,
}
