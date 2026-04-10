return {
  src = "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup {
      keymaps = {
        accept_suggestion = "<C-l>",
      },
      log_level = "off",
    }
  end,
}
