return {
  "yioneko/nvim-vtsls",
  ft = {
    "javacriptreact",
    "javascript",
    "typescript",
    "typescriptreact",
  },
  config = function()
    local opts = require("vtsls").lspconfig
    opts.settings = {
      typescript = {
        updateImportsOnFileMove = "always",
        preferences = {
          preferTypeOnlyAutoImports = true,
        },
        workspaceSymbols = {
          scope = "currentProject",
          excludeLibrarySymbols = true,
        },
      },
      javascript = {
        updateImportsOnFileMove = "always",
      },
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
            entriesLimit = 75,
          },
        },
        typescript = {
          tsserver = { maxTsServerMemory = 8192 },
        },
      },
    }
    require("lspconfig").vtsls.setup(opts)
  end,
}
