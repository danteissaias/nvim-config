return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>sf", "<cmd>Fzf files<cr>" },
    { "<leader>sg", "<cmd>Fzf live_grep_native<cr>" },
  },
  config = function()
    require("fzf-lua").setup {
      "max-perf",
      winopts = { preview = { default = "bat_native" } },
    }
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
