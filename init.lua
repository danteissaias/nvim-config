require "config.options"
require "config.keymaps"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim
    .system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
    :wait()
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.language" },
}, {
  change_detection = {
    notify = false,
  },
})
