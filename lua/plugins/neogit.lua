return {
  src = "NeogitOrg/neogit",
  dependencies = {
    { src = "nvim-lua/plenary.nvim" },
    { src = "sindrets/diffview.nvim" },
    { src = "m00qek/baleia.nvim" },
  },
  config = function()
    vim.g.baleia = require("baleia").setup({})
    require("neogit").setup {
      graph_style = "kitty",
      log_pager = { "delta", "--width", "117", "--file-style", "omit", "--hunk-header-style", "omit", "--keep-plus-minus-markers", "--paging", "never" },
    }
    vim.keymap.set("n", "<Leader>ng", ":Neogit<CR>", { silent = true })
  end,
}
