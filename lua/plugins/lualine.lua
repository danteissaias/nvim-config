return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "neo-tree" },
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
