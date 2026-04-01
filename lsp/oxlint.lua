local oxlint_settings = {
  typeAware = true,
  -- TODO: Figure out how to only enable for vite-plus repos
  -- configPath = "./vite.config.ts",
}

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = "oxlint"
    local local_cmd = (config or {}).root_dir and config.root_dir .. "/node_modules/.bin/oxlint"
    if local_cmd and vim.fn.executable(local_cmd) == 1 then
      cmd = local_cmd
    end
    return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  workspace_required = true,
  settings = oxlint_settings,
  -- INFO: we need this to make server start with correct params
  -- https://github.com/oxc-project/oxc/blob/main/crates/oxc_language_server/src/main.rs#L89-L95
  init_options = {
    settings = oxlint_settings,
  },
  root_markers = { ".oxfmtrc.json", "vite.config.ts" },
}
