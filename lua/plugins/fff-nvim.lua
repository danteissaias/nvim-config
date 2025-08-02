return {
  "dmtrKovalenko/fff.nvim",
  build = 'nix-shell -p openssl pkg-config --run "cargo build --release"',
  -- keys = {
  --   {
  --     "<leader>sf",
  --     function()
  --       require("fff").toggle()
  --     end,
  --     desc = "Toggle FFF",
  --   },
  -- },
  opts = {},
}
