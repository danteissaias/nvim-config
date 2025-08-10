return {
  "dmtrKovalenko/fff.nvim",
  build = 'nix-shell -p openssl pkg-config --run "cargo build --release"',
  keys = {
    {
      "ff",
      function()
        require("fff").find_files()
      end,
      desc = "Toggle FFF",
    },
  },
  opts = {},
}
