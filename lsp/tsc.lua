local util = require "util"

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = util.find_bin("tsc", (config or {}).root_dir)
    return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
  end,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = function(bufnr, on_dir)
    local root_markers = { { "package-lock.json", "yarn.lock", "pnpm-lock.yaml" }, { ".git" } }

    -- Fallback to the current working directory if no project root is found.
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

    on_dir(project_root)
  end,
  on_init = function(client)
    vim.lsp.semantic_tokens.enable(false, { client_id = client.id })
  end,
}
