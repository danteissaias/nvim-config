local M = {}

-- https://github.com/neovim/nvim-lspconfig/blob/12506bdaccd94964d4fb40367e36ade1960c8947/lua/lspconfig/util.lua#L47
function M.insert_package_json(config_files, field, fname)
  local path = vim.fn.fnamemodify(fname, ":h")
  local root_with_package =
    vim.fs.find({ "package.json", "package.json5" }, { path = path, upward = true })[1]

  if root_with_package then
    -- only add package.json if it contains field parameter
    for line in io.lines(root_with_package) do
      if line:find(field) then
        config_files[#config_files + 1] = vim.fs.basename(root_with_package)
        break
      end
    end
  end
  return config_files
end

return M
