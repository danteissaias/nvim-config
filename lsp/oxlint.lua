-- Based on nvim-lspconfig's lsp/oxlint.lua, with two changes for Vite+:
-- `vp` is tried first, because plain oxlint ignores the `lint` field in
-- vite.config.ts, and a Vite+ workspace roots at the workspace, not at a
-- package's own vite.config.ts.

local util = require("util")

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    if (config or {}).root_dir then
      for _, name in ipairs({ "vp", "oxlint" }) do
        local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", name)
        if vim.fn.executable(local_cmd) == 1 then
          local cmd = name == "vp" and { local_cmd, "lint", "--lsp" } or { local_cmd, "--lsp" }
          return vim.lsp.rpc.start(cmd, dispatchers)
        end
      end
    end
    return vim.lsp.rpc.start({ "oxlint", "--lsp" }, dispatchers)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local root = util.vite_plus_root(bufnr) or vim.fs.root(bufnr, { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" })
    if root then
      on_dir(root)
    end
  end,
}
