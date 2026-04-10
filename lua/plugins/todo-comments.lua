return {
  src = "folke/todo-comments.nvim",
  dependencies = {
    { src = "nvim-lua/plenary.nvim" },
  },
  config = function()
    require("todo-comments").setup {}
  end,
}
