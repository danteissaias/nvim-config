local util = require "util"

---@type vim.lsp.Config
return {
  cmd = { util.find_bin "oxfmt", "--lsp" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "toml",
    "json",
    "jsonc",
    "json5",
    "yaml",
    "html",
    "vue",
    "handlebars",
    "hbs",
    "css",
    "scss",
    "less",
    "graphql",
    "markdown",
    "mdx",
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    -- Oxfmt resolves configuration by walking upward and using the nearest config file
    -- to the file being processed. We therefore compute the root directory by locating
    -- the closest `.oxfmtrc.json` (or `package.json` fallback) above the buffer.
    local root_markers = util.insert_package_json({ ".oxfmtrc.json" }, "oxfmt", fname)[1]
    on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
  end,
}
