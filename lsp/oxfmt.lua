-- Based on nvim-lspconfig's lsp/oxfmt.lua, with two changes for Vite+:
-- `vp` is tried first, because plain oxfmt ignores the `fmt` field in
-- vite.config.ts, and a Vite+ workspace roots at the workspace, not at a
-- package's own vite.config.ts.

local util = require("util")

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    if (config or {}).root_dir then
      for _, name in ipairs({ "vp", "oxfmt" }) do
        local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", name)
        if vim.fn.executable(local_cmd) == 1 then
          local cmd = name == "vp" and { local_cmd, "fmt", "--lsp" } or { local_cmd, "--lsp" }
          return vim.lsp.rpc.start(cmd, dispatchers)
        end
      end
    end
    return vim.lsp.rpc.start({ "oxfmt", "--lsp" }, dispatchers)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "toml",
    "json",
    "jsonc",
    "json5",
    "yaml",
    "html",
    "vue",
    "handlebars",
    "css",
    "scss",
    "less",
    "graphql",
    "markdown",
    "svelte",
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local root = util.vite_plus_root(bufnr) or vim.fs.root(bufnr, { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" })
    if root then
      on_dir(root)
    end
  end,
}
