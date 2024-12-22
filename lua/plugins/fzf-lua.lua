return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>sf", "<cmd>Fzf files<cr>" },
    { "<leader>sg", "<cmd>Fzf live_grep_native<cr>" },
  },
  config = function()
    require("fzf-lua").setup { "max-perf" }
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
