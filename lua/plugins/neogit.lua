return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  keys = {
    { "<Leader>ng", ":Neogit<CR>", silent = true },
  },
  opts = {
    graph_style = "kitty",
  },
}
