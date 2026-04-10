return {
  src = "ibhagwan/fzf-lua",
  dependencies = {
    { src = "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    require("fzf-lua").setup {
      "max-perf",
      winopts = { preview = { default = "bat_native" } },
      keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } },
    }

    vim.keymap.set("n", "<leader>sf", "<cmd>Fzf files<cr>")
    vim.keymap.set("n", "<leader>sg", "<cmd>Fzf live_grep_native<cr>")
    vim.keymap.set("n", "z=", "<cmd>FzfLua spell_suggest<cr>")
  end,
}
