return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    servers = {
      cssls = {},
      eslint = {},
      html = {},
      jsonls = function()
        return {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = {
                enable = true,
              },
            },
          },
        }
      end,
      lua_ls = {},
      tailwindcss = {},
      vtsls = {
        settings = {
          typescript = {
            updateImportsOnFileMove = "always",
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
              },
            },
            typescript = {
              tsserver = { maxTsServerMemory = 8192 },
            },
          },
        },
      },
      yamlls = {},
      biome = {},
    },
  },
  config = function(_, opts)
    local capabilities = require("lsp").capabilities()
    for server, config in pairs(opts.servers) do
      config = type(config) == "function" and config() or config
      config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
      require("lspconfig")[server].setup(config)
    end
  end,
  dependencies = {
    "b0o/SchemaStore.nvim",
  },
}
