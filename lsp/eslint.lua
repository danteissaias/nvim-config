local util = require "util"

---@type vim.lsp.Config
return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "graphql" },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local root_files = {
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.json",
      "eslint.config.js",
      "eslint.config.mjs",
    }
    local fname = vim.api.nvim_buf_get_name(bufnr)
    root_files = util.insert_package_json(root_files, "eslintConfig", fname)
    on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
  end,
  -- Using roughly the same defaults as nvim-lspconfig: https://github.com/neovim/nvim-lspconfig/blob/d3ad666b7895f958d088cceb6f6c199672c404fe/lua/lspconfig/configs/eslint.lua#L70
  settings = {
    validate = "on",
    packageManager = nil,
    useESLintClass = false,
    experimental = { useFlatConfig = false },
    codeActionOnSave = { enable = false, mode = "all" },
    format = false,
    quiet = false,
    onIgnoredFiles = "off",
    options = {},
    rulesCustomizations = {},
    run = "onType",
    problems = { shortenToSingleLine = false },
    nodePath = "",
    workingDirectory = { mode = "location" },
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
  },
  before_init = function(params, config)
    -- Set the workspace folder setting for correct search of tsconfig.json files etc.
    config.settings.workspaceFolder = {
      uri = params.rootPath,
      name = vim.fn.fnamemodify(params.rootPath, ":t"),
    }
  end,
  ---@type table<string, lsp.Handler>
  handlers = {
    ["eslint/openDoc"] = function(_, params)
      vim.ui.open(params.url)
      return {}
    end,
    ["eslint/probeFailed"] = function()
      vim.notify("LSP[eslint]: Probe failed.", vim.log.levels.WARN)
      return {}
    end,
    ["eslint/noLibrary"] = function()
      vim.notify("LSP[eslint]: Unable to load ESLint library.", vim.log.levels.WARN)
      return {}
    end,
  },
}
