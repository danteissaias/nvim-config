return {
  src = "stevearc/oil.nvim",
  dependencies = {
    { src = "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    require("oil").setup {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return name == ".."
        end,
      },
    }
    vim.keymap.set("n", "-", "<cmd>Oil<cr>")
    vim.keymap.set("n", "_", "<cmd>Oil .<cr>")
  end,
}
