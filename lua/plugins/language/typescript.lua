return {
  "yioneko/nvim-vtsls",
  ft = {
    "javacriptreact",
    "javascript",
    "typescript",
    "typescriptreact",
  },
  config = function()
    require("lspconfig.configs").vtsls = require("vtsls").lspconfig

    local settings = {
      typescript = {
        preferences = {
          preferTypeOnlyAutoImports = true,
        },
        workspaceSymbols = {
          scope = "currentProject",
          excludeLibrarySymbols = true,
        },
      },
      vtsls = {
        autoUseWorkspaceTsdk = true,
        -- experimental = {
        --   completion = {
        --     enableServerSideFuzzyMatch = true,
        --     entriesLimit = 75,
        --   },
        -- },
        typescript = {
          tsserver = { maxTsServerMemory = 8192 },
        },
      },
    }

    require("lspconfig").vtsls.setup(settings)
  end,
}
