return {
  src = "chrishrb/gx.nvim",
  config = function()
    vim.g.netrw_nogx = 1
    require("gx").setup {}
    vim.keymap.set({ "n", "x" }, "gx", "<cmd>Browse<cr>")
  end,
}
