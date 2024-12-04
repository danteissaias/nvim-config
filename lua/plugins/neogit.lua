return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<Leader>ng", ":Neogit<CR>", silent = true },
  },
  opts = {
    graph_style = "kitty",
  },
}
