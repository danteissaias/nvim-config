local util = require "util"

local oxlint_settings = {
  typeAware = true,
}

---@type vim.lsp.Config
return {
  cmd = { "oxc_language_server" },
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
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root_markers = util.insert_package_json({ ".oxlintrc.json" }, "oxlint", fname)
    on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
  end,
}
