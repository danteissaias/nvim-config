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

    local opts = {
      settings = {
        typescript = {
          preferences = {
            preferTypeOnlyAutoImports = true,
          },
          workspaceSymbols = {
            scope = "currentProject",
            excludeLibrarySymbols = true,
          },
          tsserver = {
            nodePath = "~/.config/nvim/run-electron-as-node",
            maxTsServerMemory = 8192,
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
        },
      },
    }

    require("lspconfig").vtsls.setup(opts)
  end,
}
