return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>sf", "<cmd>Telescope find_files<cr>" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>" },
  },
  cmd = "Telescope",
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension "fzf"
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}
