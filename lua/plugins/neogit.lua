return {
  src = "NeogitOrg/neogit",
  dependencies = {
    { src = "nvim-lua/plenary.nvim" },
    { src = "sindrets/diffview.nvim" },
  },
  config = function()
    require("neogit").setup {
      graph_style = "kitty",
    }
    vim.keymap.set("n", "<Leader>ng", ":Neogit<CR>", { silent = true })
  end,
}
