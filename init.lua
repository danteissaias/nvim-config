require "options"
require "keymaps"
require "lsp"
require "commands"

local pack = require "pack"
local plugins = {}
for _, file in ipairs(vim.fn.glob(vim.fn.stdpath "config" .. "/lua/plugins/*.lua", false, true)) do
  local mod = file:match("lua/(.+)%.lua$"):gsub("/", ".")
  table.insert(plugins, require(mod))
end

pack.setup(plugins)

require("vim._core.ui2").enable {}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local ok, _ = pcall(vim.treesitter.language.get_lang, vim.bo.filetype)
    if ok then
      pcall(vim.treesitter.start)
    end
  end,
})
