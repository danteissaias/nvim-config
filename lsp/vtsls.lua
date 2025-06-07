local jsts_settings = {
  tsserver = {
    nodePath = "~/.config/nvim/run-electron-as-node",
    maxTsServerMemory = 8192,
  },
}

---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascriptreact", "javascript", "typescript", "typescriptreact" },
  root_dir = function(bufnr, cb)
    local fname = vim.uri_to_fname(vim.uri_from_bufnr(bufnr))

    local ts_root = vim.fs.find("tsconfig.json", { upward = true, path = fname })[1]
    -- Use the git root to deal with monorepos where TypeScript is installed in the root node_modules folder.
    local git_root = vim.fs.find(".git", { upward = true, path = fname })[1]

    if git_root then
      cb(vim.fn.fnamemodify(git_root, ":h"))
    elseif ts_root then
      cb(vim.fn.fnamemodify(ts_root, ":h"))
    end
  end,
  settings = {
    typescript = jsts_settings,
    javascript = jsts_settings,
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
  },
}
