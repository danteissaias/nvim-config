return {
  src = "folke/flash.nvim",
  config = function()
    require("flash").setup {}
    vim.keymap.set({ "n", "x", "o" }, "s", function()
      require("flash").jump()
    end)
  end,
}
