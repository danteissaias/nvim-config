return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    servers = {
      eslint = {
        root_dir = function(filename)
          if string.find(filename, "node_modules/") then
            return nil
          end

          return require("lspconfig.configs.eslint").default_config.root_dir(filename)
        end,
      },
      lua_ls = {},
      tailwindcss = {},
      yamlls = {},
      biome = {},
      nil_ls = {},
      jsonls = function()
        return {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        }
      end,
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
    "Saghen/blink.cmp",
  },
}
