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

function M.find_bin(name, root_dir)
  if root_dir then
    local local_bin = root_dir .. "/node_modules/.bin/" .. name
    if vim.fn.executable(local_bin) == 1 then
      return local_bin
    end
  end
  return name
end

-- The workspace root (next to its lockfile) when its package.json depends on vite-plus.
-- Vite+ keeps the lint and fmt config in that root's vite.config.ts.
-- From https://github.com/chenxin-yan/nix-dotfiles/blob/3e667232510a768bef8f8040e1fbf39f4acad3e0/modules/features/cli/nvim/config/lua/cyan/plugins/languages/web/viteplus.lua
function M.vite_plus_root(source)
  local root = vim.fs.root(source, {
    { "pnpm-workspace.yaml", "pnpm-lock.yaml", "package-lock.json", "yarn.lock", "bun.lock", "bun.lockb" },
    "package.json",
  })
  if not root then
    return nil
  end
  local ok, package = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(vim.fs.joinpath(root, "package.json")), "\n"))
  end)
  if ok and type(package) == "table" then
    for _, key in ipairs({ "dependencies", "devDependencies" }) do
      if type(package[key]) == "table" and package[key]["vite-plus"] then
        return root
      end
    end
  end
  return nil
end

return M
