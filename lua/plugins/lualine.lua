return {
  src = "nvim-lualine/lualine.nvim",
  dependencies = {
    { src = "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    require("lualine").setup {
      options = {
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "neo-tree" },
      },
    }
  end,
}
